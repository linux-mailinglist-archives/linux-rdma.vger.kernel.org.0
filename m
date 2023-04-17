Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64C36E46A7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDQLkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Apr 2023 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjDQLkk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Apr 2023 07:40:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964CB901A;
        Mon, 17 Apr 2023 04:40:01 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [7.185.36.203])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q0Q365wPVzSsrp;
        Mon, 17 Apr 2023 19:35:30 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 19:39:01 +0800
Message-ID: <3f478e2e-c91e-fb3e-19a8-4c9939e101a7@huawei.com>
Date:   Mon, 17 Apr 2023 19:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 4.19 v3 6/6] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
References: <20230228080630.52370-1-guozihua@huawei.com>
 <20230228080630.52370-7-guozihua@huawei.com>
In-Reply-To: <20230228080630.52370-7-guozihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/2/28 16:06, GUO Zihua wrote:
> [ Upstream commit c7423dbdbc9ecef7fff5239d144cad4b9887f4de ]
> 
> IMA relies on the blocking LSM policy notifier callback to update the
> LSM based IMA policy rules.
> 
> When SELinux update its policies, IMA would be notified and starts
> updating all its lsm rules one-by-one. During this time, -ESTALE would
> be returned by ima_filter_rule_match() if it is called with a LSM rule
> that has not yet been updated. In ima_match_rules(), -ESTALE is not
> handled, and the LSM rule is considered a match, causing extra files
> to be measured by IMA.
> 
> Fix it by re-initializing a temporary rule if -ESTALE is returned by
> ima_filter_rule_match(). The origin rule in the rule list would be
> updated by the LSM policy notifier callback.
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 40 ++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 5256ff008f11..e9e15e622cf2 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -374,6 +374,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			    enum ima_hooks func, int mask)
>  {
>  	int i;
> +	bool result = false;
> +	struct ima_rule_entry *lsm_rule = rule;
> +	bool rule_reinitialized = false;
>  
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
> @@ -412,38 +415,57 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		int rc = 0;
>  		u32 osid;
>  
> -		if (!rule->lsm[i].rule) {
> -			if (!rule->lsm[i].args_p)
> +		if (!lsm_rule->lsm[i].rule) {
> +			if (!lsm_rule->lsm[i].args_p)
>  				continue;
>  			else
>  				return false;
>  		}
> +
> +retry:
>  		switch (i) {
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
>  		case LSM_OBJ_TYPE:
>  			security_inode_getsecid(inode, &osid);
>  			rc = security_filter_rule_match(osid,
> -							rule->lsm[i].type,
> +							lsm_rule->lsm[i].type,
>  							Audit_equal,
> -							rule->lsm[i].rule,
> +							lsm_rule->lsm[i].rule,
>  							NULL);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
>  			rc = security_filter_rule_match(secid,
> -							rule->lsm[i].type,
> +							lsm_rule->lsm[i].type,
>  							Audit_equal,
> -							rule->lsm[i].rule,
> +							lsm_rule->lsm[i].rule,
>  							NULL);
>  		default:
>  			break;
>  		}
> -		if (!rc)
> -			return false;
> +
> +		if (rc == -ESTALE && !rule_reinitialized) {
> +			lsm_rule = ima_lsm_copy_rule(rule);
> +			if (lsm_rule) {
> +				rule_reinitialized = true;
> +				goto retry;
> +			}
> +		}
> +		if (!rc) {
> +			result = false;
> +			goto out;
> +		}
> +	}
> +	result = true;
> +
> +out:
> +	if (rule_reinitialized) {
> +		ima_lsm_free_rule(lsm_rule);
> +		kfree(lsm_rule);
>  	}
> -	return true;
> +	return result;
>  }
>  
>  /*

Ping?

-- 
Best
GUO Zihua

