Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D051CDD47
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgEKOcA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 10:32:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:14458 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgEKOcA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 10:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589207520; x=1620743520;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9ngykYpKPpOaDrLI5pM3ltoeW/DM9K9GJCGzRgBueP4=;
  b=oIW8jGqHouJUbizZ+5iMgpkO+7aBmoBm5oK/hoCOBcvkOVDeGJKq53t2
   z2fXuhXfcpu3nMZsaagjXdj6fj+arAcGOQ7IRCb9kjGvFNH9vFIyL+liv
   en12vVs84PPfqhUZU4sTmITjRUo2NBJPKkbvfRQx385WbsHt1mAemC2ER
   8=;
IronPort-SDR: dmfSKfzdyJyno6S5C/AQ9kjsRCiPVNkoHZCzSNZqa/LOC6LTlSpuNORuaN1HMuQ9gLVWZfW9yg
 uaKvThw5frdw==
X-IronPort-AV: E=Sophos;i="5.73,380,1583193600"; 
   d="scan'208";a="42552274"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 May 2020 14:31:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id D4E98A0597;
        Mon, 11 May 2020 14:31:55 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 14:31:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.90) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 14:31:51 +0000
Subject: Re: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device,
 PD, MR
To:     Yishai Hadas <yishaih@mellanox.com>, <linux-rdma@vger.kernel.org>
CC:     <jgg@mellanox.com>, <maorg@mellanox.com>, <Alexr@mellanox.com>
References: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com>
Date:   Mon, 11 May 2020 17:31:46 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D14UWB002.ant.amazon.com (10.43.161.216) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/05/2020 16:12, Yishai Hadas wrote:
> Introduce import verbs for device, PD, MR, it enables processes to share
> their ibv_contxet and then share PD and MR that is associated with.
> 
> A process is creating a device and then uses some of the Linux systems
> calls to dup its 'cmd_fd' member which lets other process to obtain
> owning on.
> 
> Once other process obtains the 'cmd_fd' it can call ibv_import_device()
> which returns an ibv_contxet on the original RDMA device.
> 
> On the imported device there is an option to import PD(s) and MR(s) to
> achieve a sharing on those objects.
> 
> This is the responsibility of the application to coordinate between all
> ibv_context(s) that use the imported objects, such that once destroy is
> done no other process can touch the object except for unimport. All
> users of the context must collaborate to ensure this.
> 
> A matching unimport verbs where introduced for PD and MR, for the device
> the ibv_close_device() API should be used.
> 
> Detailed man pages are introduced as part of this RFC patch to clarify
> the expected usage and notes.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>

Hi Yishai,

A few questions:
Can you please explain the use case? I remember there was a discussion on the
previous shared PD kernel submission (by Yuval and Shamir) but I'm not sure if
there was a conclusion.

Could you please elaborate more how the process cleanup flow (e.g killed
process) is going to change? I know it's a very broad question but I'm just
trying to get the general idea.

What's expected to happen in a case where we have two processes P1 & P2, both
use a shared PD, but separate MRs and QPs (created under the same shared PD).
Now when an RDMA read request arrives at P2's QP, but refers to an MR of P1
(which was not imported, but under the same PD), how would you expect the device
to handle that?
