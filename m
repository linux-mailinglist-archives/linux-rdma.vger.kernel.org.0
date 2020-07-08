Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893052187DC
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 14:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgGHMmu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 08:42:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:35726 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgGHMmu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jul 2020 08:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594212170; x=1625748170;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=isVgfoV2yYhdnmK1vsfgbEyDHnYtI8sjoMaUdEHBkkY=;
  b=aI2k874vxfO7Irdiaf2e4wSlLOxYMry7GmF6sNVCPJ3c86JpSlxvS2Nd
   kGbqBiJEIQS/penySUjvJplKZOD2hC5pqe0MX1CKGL03Qk1wPrOUbTQTh
   GLu94cMBwpmUUEE4lEfim2j94uT8vBn7Kqe1vfUk4xgofVl7uo0xh8JrQ
   Y=;
IronPort-SDR: 60CP2Ri9gzLqEDS9aiRHhnzrIMepgx45AFRVSaFbmJ7VRTcN9ATJro8ZFEhM2h+FxbOi5q/qUG
 mF7lZ5DQVNGg==
X-IronPort-AV: E=Sophos;i="5.75,327,1589241600"; 
   d="scan'208";a="40680995"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 08 Jul 2020 12:42:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 8F9F628ABDC;
        Wed,  8 Jul 2020 12:42:44 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Jul 2020 12:42:43 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.140) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Jul 2020 12:42:40 +0000
Subject: Re: Question about IB_QP_CUR_STATE
To:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>
References: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <881488e6-03d8-1e01-076c-5c901d84a44a@amazon.com>
Date:   Wed, 8 Jul 2020 15:42:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D17UWC002.ant.amazon.com (10.43.162.61) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/07/2020 12:41, liweihang wrote:
> Hi all,
> 
> I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
> ib_qp_attr_mask.
> 
> In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
> is the current QP state". Why we need to get current qp state from users
> instead of drivers?
> 
> For example, why the users are allowed to modify qp from RTR to RTS again
> even if the qp's state in driver and hardware has already been RTS.
> 
> I would be appretiate it if someone can help with this.
> 
> Weihang
> 

Talking about IB_QP_CUR_STATE, I see many drivers filling it in their query QP
callback although it should only be used in modify operations.. Is there a
reason not to remove it?
