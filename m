Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AC62D6AC
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 10:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiKQJZS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 04:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiKQJZC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 04:25:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20B62704
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 01:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2F7DB81D97
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 09:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263C9C433C1;
        Thu, 17 Nov 2022 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668677082;
        bh=Hlm/U+6P1WqWr9fWknvKKaxOGxsXPT9CvB+0+SVSWZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtVpKkYcH/bDWMEapvLGo+IMJ/0GJvfc8Qdzog/WAOxxmZl5bxLh42UMitDTbvFF1
         Nx+arIGLX3BVeDBdjOCV3gJDkJhEeIi8jKlMEy57X0oJzSNNjVvevSY+dRDBHcGWR3
         FltD0Pf446dH+mBh4sQwu1//+PMqEmrC05d4b1PzXyUrb7ozUzZi0nrAt/lhPL0Hxi
         IHk0XvvAnVHsf2rsMV+IXhJPYj7PbcYZoowL3LeUkeLsis6Xl/yjsx08kVLOaglXvF
         ALwUD0pE9HAfFfGZANXSyymym8TJ0RB5fFSDUM0aa/Ihax8UKZt8AClbPwhI/3wRNo
         9CbcBeLN2tWfw==
Date:   Thu, 17 Nov 2022 11:24:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     faisal.latif@intel.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] iwpm: crash fix for large connections test
Message-ID: <Y3X91h5Fla+4mICY@unreal>
References: <Y3ORbHXv5M8X8kqN@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ORbHXv5M8X8kqN@kili>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 15, 2022 at 04:17:32PM +0300, Dan Carpenter wrote:
> [ This isn't really the correct patch to blame.  Sorry! -dan ]
> 
> Hello Faisal Latif,
> 
> The patch dafb5587178a: "iwpm: crash fix for large connections test"
> from Feb 26, 2016, leads to the following Smatch static checker
> warning:
> 
> drivers/infiniband/core/iwpm_msg.c:437 iwpm_register_pid_cb() warn: 'nlmsg_request' was already freed.
> drivers/infiniband/core/iwpm_msg.c:509 iwpm_add_mapping_cb() warn: 'nlmsg_request' was already freed.
> drivers/infiniband/core/iwpm_msg.c:607 iwpm_add_and_query_mapping_cb() warn: 'nlmsg_request' was already freed.
> drivers/infiniband/core/iwpm_msg.c:806 iwpm_mapping_error_cb() warn: 'nlmsg_request' was already freed.
> 
> drivers/infiniband/core/iwpm_msg.c
>     385 int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_callback *cb)
>     386 {
>     387         struct iwpm_nlmsg_request *nlmsg_request = NULL;
>     388         struct nlattr *nltb[IWPM_NLA_RREG_PID_MAX];
>     389         struct iwpm_dev_data *pm_msg;
>     390         char *dev_name, *iwpm_name;
>     391         u32 msg_seq;
>     392         u8 nl_client;
>     393         u16 iwpm_version;
>     394         const char *msg_type = "Register Pid response";
>     395 
>     396         if (iwpm_parse_nlmsg(cb, IWPM_NLA_RREG_PID_MAX,
>     397                                 resp_reg_policy, nltb, msg_type))
>     398                 return -EINVAL;
>     399 
>     400         msg_seq = nla_get_u32(nltb[IWPM_NLA_RREG_PID_SEQ]);
>     401         nlmsg_request = iwpm_find_nlmsg_request(msg_seq);
>     402         if (!nlmsg_request) {
>     403                 pr_info("%s: Could not find a matching request (seq = %u)\n",
>     404                                  __func__, msg_seq);
>     405                 return -EINVAL;
>     406         }
>     407         pm_msg = nlmsg_request->req_buffer;
>     408         nl_client = nlmsg_request->nl_client;
>     409         dev_name = (char *)nla_data(nltb[IWPM_NLA_RREG_IBDEV_NAME]);
>     410         iwpm_name = (char *)nla_data(nltb[IWPM_NLA_RREG_ULIB_NAME]);
>     411         iwpm_version = nla_get_u16(nltb[IWPM_NLA_RREG_ULIB_VER]);
>     412 
>     413         /* check device name, ulib name and version */
>     414         if (strcmp(pm_msg->dev_name, dev_name) ||
>     415                         strcmp(iwpm_ulib_name, iwpm_name) ||
>     416                         iwpm_version < IWPM_UABI_VERSION_MIN) {
>     417 
>     418                 pr_info("%s: Incorrect info (dev = %s name = %s version = %u)\n",
>     419                                 __func__, dev_name, iwpm_name, iwpm_version);
>     420                 nlmsg_request->err_code = IWPM_USER_LIB_INFO_ERR;
>     421                 goto register_pid_response_exit;
>     422         }
>     423         iwpm_user_pid = cb->nlh->nlmsg_pid;
>     424         iwpm_ulib_version = iwpm_version;
>     425         if (iwpm_ulib_version < IWPM_UABI_VERSION)
>     426                 pr_warn_once("%s: Down level iwpmd/pid %d.  Continuing...",
>     427                         __func__, iwpm_user_pid);
>     428         atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
>     429         pr_debug("%s: iWarp Port Mapper (pid = %d) is available!\n",
>     430                         __func__, iwpm_user_pid);
>     431         iwpm_set_registration(nl_client, IWPM_REG_VALID);
>     432 register_pid_response_exit:
>     433         nlmsg_request->request_done = 1;
>     434         /* always for found nlmsg_request */
>     435         kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
> 
> The iwpm_free_nlmsg_request() function will free "nlmsg_request"...
> It's not clear what the "/* always for found nlmsg_request */" comment
> means.  Maybe it means that the refcount won't drop to zero so the
> free function won't be called?

I think so. The nlmsg_request reference counter is elevated when it is
found in iwpm_find_nlmsg_request(). So I assume that it will be at least
2 before call to kref_put(). Most likely, nlmsg_request->sem prevents
from parallel threads to decrease that reference counter.

BTW, not IWPM expert.

Thanks
