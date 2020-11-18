Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D952B7DCB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKRMqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:46:46 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:45536 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgKRMqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 07:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605703606; x=1637239606;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=LP4XcxFu62nvTGuYs0jGZpfpZ8G2pgqAUVLsEkoXe6c=;
  b=ASePM8ZzmEyXeDTXVWqK4DeMCO2rdLxpt3t6GG03BvF8+BwQ/so/1F2e
   JPzymN8Hyu05Fc4eqOdsXENW2CNH9POCVPwubh+QI6g23+DPYjpJ1Ny3n
   FpCcBP6bK8Q8wJGJfYZcQcGVmeRNl8Gn/5FJxBzhYH1jHrNNyur5HBDul
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="88353943"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Nov 2020 12:46:14 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 96A22A1604;
        Wed, 18 Nov 2020 12:46:13 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.144) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 12:46:10 +0000
Subject: Re: [PATCH 8/9] verbs: Remove dead code
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <8-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <c78be7ca-7a04-6a7e-5a55-06a2dd58e947@amazon.com>
Date:   Wed, 18 Nov 2020 14:46:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <8-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.144]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 22:23, Jason Gunthorpe wrote:
> Remove the old query_device support code, it is now replaced by
> ibv_cmd_query_device_any()
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Shouldn't the legacy fallback in ibv_query_device_ex() be removed as well?

/**
 * ibv_query_device_ex - Get extended device properties
 */
static inline int
ibv_query_device_ex(struct ibv_context *context,
		    const struct ibv_query_device_ex_input *input,
		    struct ibv_device_attr_ex *attr)
{
	struct verbs_context *vctx;
	int ret;

	if (input && input->comp_mask)
		return EINVAL;

	vctx = verbs_get_ctx_op(context, query_device_ex);
	if (!vctx)
		goto legacy;

	ret = vctx->query_device_ex(context, input, attr, sizeof(*attr));
	if (ret == EOPNOTSUPP || ret == ENOSYS)
		goto legacy;

	return ret;

legacy:
	memset(attr, 0, sizeof(*attr));
	ret = ibv_query_device(context, &attr->orig_attr);

	return ret;
}
