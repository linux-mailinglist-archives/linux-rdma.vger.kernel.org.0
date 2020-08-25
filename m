Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F32517FE
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgHYLo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 07:44:58 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46181 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgHYLoz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 07:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598355895; x=1629891895;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mGsBoXS6LJbPfZEAvfD9YzRPHg9T2iOIgxgSqnspuNQ=;
  b=JUgveYOT6lRUHulpnZHTLL/nA2Uz8jZMMGfsUJgAE0ijfZmv8WWxSoGk
   Fq2Zr02gNf0is/T3z07/6kdquRaVdWboLN52PooeAzYy5kM7U7RkAlVBC
   Lc3N1P26vGT2k3R0bCZkXRo8NYrFdbWUEfXvhDMcY+eNsxpFaXxfsev47
   M=;
X-IronPort-AV: E=Sophos;i="5.76,352,1592870400"; 
   d="scan'208";a="70737475"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Aug 2020 11:44:53 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id E9632A1E2D;
        Tue, 25 Aug 2020 11:44:51 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.85) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Aug 2020 11:44:47 +0000
Subject: Re: [PATCH for-rc 1/6] RDMA/bnxt_re: Remove the qp from list only if
 the qp destroy succeeds
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
 <1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com>
 <20200824190141.GL571722@unreal>
 <CA+sbYW3R_uScvS63dWNNVO4965OjOCRPagpqOY1JKrbsOTEEeQ@mail.gmail.com>
 <20200824220002.GF24045@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8f629ba0-4862-70a4-f2e3-6721653a4955@amazon.com>
Date:   Tue, 25 Aug 2020 14:44:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824220002.GF24045@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D45UWB003.ant.amazon.com (10.43.161.67) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2020 1:00, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2020 at 01:06:23AM +0530, Selvin Xavier wrote:
>> On Tue, Aug 25, 2020 at 12:31 AM Leon Romanovsky <leon@kernel.org> wrote:
>>>
>>> On Mon, Aug 24, 2020 at 11:14:31AM -0700, Selvin Xavier wrote:
>>>> Driver crashes when destroy_qp is re-tried because of an
>>>> error returned. This is because the qp entry was  removed
>>>> from the qp list during the first call.
>>>
>>> How is it possible that destroy_qp fail?
>>>
>> One possibility is when the FW is in a crash state.   Driver commands
>> to FW  fails and it reports an error status for destroy_qp verb.
>> Even Though the chances of this failure is less,  wanted to avoid a
>> host crash seen in this scenario.
> 
> Drivers are not allowed to fail destroy - the only exception is if a
> future destroy would succeed for some reason.

Why?
We already have the iterative cleanup in uverbs_destroy_ufile_hw, and combined
with Leon's changes it makes sense that the actual return value is returned
instead of ignored.

If the subsystem handles it for DEVX, why shouldn't it handle it for other drivers?
