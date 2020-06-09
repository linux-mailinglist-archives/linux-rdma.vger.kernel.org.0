Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68A1F4033
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgFIQEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgFIQEK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 12:04:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4352C05BD1E;
        Tue,  9 Jun 2020 09:04:09 -0700 (PDT)
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66A8E291;
        Tue,  9 Jun 2020 18:04:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591718646;
        bh=YiIP5a5/hJGYDmwjgLKGoPBcEsEiQuHwdo3Xcf8Mei0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ticQN8WIsqg4uaeU/viMuhpJi6Qmb36BGBAmdRNTrngIhGfRdtjxuOa4t8xvFB8Jh
         Y86KQ0il8Ym0FPjwN0xTKGtGJpJx3hdoWdEO8z8r+pNKKwNwuwV29xNBVJi6875jH1
         9P3d1q4Bp3kgyOoVzEt6d/uLWPTvOgzmNkz2x5hw=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 11/17] drivers: infiniband: Fix trivial spelling
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
 <20200609124610.3445662-12-kieran.bingham+renesas@ideasonboard.com>
 <80843bf3-25a3-37b0-f687-9a5e01546c72@intel.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <40b92c85-4108-dabe-a6a4-481c0336e45a@ideasonboard.com>
Date:   Tue, 9 Jun 2020 17:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <80843bf3-25a3-37b0-f687-9a5e01546c72@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ooops,

Looks like that should have been part of patch 2/17.

Must have got split during the rebase I made or something, not sure.

On 09/06/2020 16:54, Dennis Dalessandro wrote:
> On 6/9/2020 8:46 AM, Kieran Bingham wrote:
>> The word 'descriptor' is misspelled throughout the tree.
>>
>> Fix it up accordingly:
>>      decriptors -> descriptors
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>   drivers/infiniband/hw/hfi1/ipoib_tx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c
>> b/drivers/infiniband/hw/hfi1/ipoib_tx.c
>> index 883cb9d48022..175290c56db9 100644
>> --- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
>> +++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
>> @@ -364,7 +364,7 @@ static struct ipoib_txreq
>> *hfi1_ipoib_send_dma_common(struct net_device *dev,
>>       if (unlikely(!tx))
>>           return ERR_PTR(-ENOMEM);
>>   -    /* so that we can test if the sdma decriptors are there */
>> +    /* so that we can test if the sdma descriptors are there */
>>       tx->txreq.num_desc = 0;
>>       tx->priv = priv;
>>       tx->txq = txp->txq;
>>
> 
> Thanks
> 
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Thanks.

Kieran




