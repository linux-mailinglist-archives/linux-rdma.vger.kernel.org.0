Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FE72B7DD1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKRMsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:48:07 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:53868 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgKRMsH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 07:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605703687; x=1637239687;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=WMKZ/JDOuhSxM5k963vNiuDM6kyH3qDL6MrKWFaY7Jo=;
  b=HWX09jZ0YYy3rQitafFXtnZKyvdTcMYKQyWCU92tfq93s4t5MKRigDvr
   oGIB2vzB181H1VgzVICDky94WqDOarF4Lg8E1aBCKbW1ILAuzn/9bf1XB
   dOBJ138YydKmOfPTFeeejtJd/E9NJBNbAOH8Z2REbmAzFdO9nIMdbdN9Z
   A=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="67165310"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-76e0922c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Nov 2020 12:48:00 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-76e0922c.us-west-2.amazon.com (Postfix) with ESMTPS id 70C43A868A;
        Wed, 18 Nov 2020 12:47:58 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 12:47:56 +0000
Subject: Re: [PATCH 6/9] providers: Remove normal query_device() from
 providers that have _ex
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <6-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <37245b05-bc88-2d8d-d6f9-6cd53d2e1dfb@amazon.com>
Date:   Wed, 18 Nov 2020 14:47:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <6-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D06UWC003.ant.amazon.com (10.43.162.86) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 22:23, Jason Gunthorpe wrote:
> The ex callback can implement both versions, no reason for duplicate
> code in two paths. Have the core code call the _ex version instead.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Gal Pressman <galpress@amazon.com>
