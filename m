Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2039F359
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFHK1U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 06:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhFHK1T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 06:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623147902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7w2d2fVA3ni4DuU+rsQANTW9/Be4Bv7NX97VnuwJWhQ=;
        b=PflxHH6LIZyl0+TuZq0SZQ4rp7LjgNgtTmn4XAGbF1Sn8HWKUPxVqg2w2xmyRXsmWLjPjU
        wWcRPHZW8ZN/8iiVaIY7RfReiPoLrDsxED3iNtNC2ccehH4etPSmZEqaXDz/1mIZSFmrrK
        LMltagiOIuJI5E6f0ikit5bgsEbXLE4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-oS5ZBaKSNBWCAHaIJz3bGw-1; Tue, 08 Jun 2021 06:25:01 -0400
X-MC-Unique: oS5ZBaKSNBWCAHaIJz3bGw-1
Received: by mail-wm1-f71.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so999074wms.5
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 03:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7w2d2fVA3ni4DuU+rsQANTW9/Be4Bv7NX97VnuwJWhQ=;
        b=VbqtG4ZvHs7cOXokM6+cp9ROnzKaAPIPs1Qrvg/URgH7RdVKmf6Clg3v9P9wskK3RH
         dsh8zG7MsCn9k2sRBiJ2DJH7qCXb+O8qg501SnAL4wSKoMXT9c82fEPr5sOsUUr1Ko4B
         HlBPQhRWhY/uRhTxz5fQ4v3tTd5xheHuC1vI3CaHc7L1AJ5a/PPValHF6Ug0kVhziMVj
         CfByTofz7i0lGBq6PU3aC1wkSZCxWVjtHqhoh9Zm2LBROcWK2/FjjotaHl65BnjP3ZQh
         bALDbeTSo2Lzakvg5Qe2/7qP1cuJhuYDVfblXbrKRGrCQJs8xdtc8OHDel0sy8Q0i21X
         Quwg==
X-Gm-Message-State: AOAM533vh1I/rOyLh/I01dr79vBUuCzBb1QgF/kTiOiiV9vgcIrNEj2e
        Qmv3R9L+ozGyt3ZuqmI1XeeSntEWJpHPqG/TBsd+J2CPjgMDqAVXt1N5Nw5czm+YjotK5CeFur7
        ghYmcgqz6/1fGy/WY1VtI9g==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr21657659wmq.42.1623147900278;
        Tue, 08 Jun 2021 03:25:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMDNv13Fj8jMFPKln7lIVR7h7BF8hgLGldc6Iv0fNFdEU8uqzeyoXSjPI4BynZwZrDd8+Img==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr21657650wmq.42.1623147900144;
        Tue, 08 Jun 2021 03:25:00 -0700 (PDT)
Received: from [192.168.68.114] (bzq-109-67-139-103.red.bezeqint.net. [109.67.139.103])
        by smtp.gmail.com with ESMTPSA id c64sm2516682wma.15.2021.06.08.03.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 03:24:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     israelr@nvidia.com, alaa@nvidia.com,
        Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
From:   Kamal Heib <kheib@redhat.com>
Message-ID: <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
Date:   Tue, 8 Jun 2021 13:24:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/25/21 7:22 PM, Max Gurtovoy wrote:
> 
> On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>>> Since the Linux iser initiator default max I/O size set to 512KB and
>>> since there is no handshake procedure for this size in iser protocol,
>>> set the default max IO size of the target to 512KB as well.
>>>
>>> For changing the default values, there is a module parameter for both
>>> drivers.
>>
>> Is this solving a bug?
> 
> No. Only OOB for some old connect-IB devices.
> 
> I think it's reasonable to align initiator and target defaults anyway.
> 
> 

Actually, this patch is solving a bug when trying iser over Connect-IB, We see
the following failure when trying to do discovery:

Server:
[  124.264648] infiniband mlx5_0: create_qp:2783:(pid 83): Create QP type 2 failed
[  124.298598] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  124.364768] isert: isert_cma_handler: failed handle connect request -12
[  128.271609] infiniband mlx5_0: create_qp:2783:(pid 890): Create QP type 2 failed
[  128.311450] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  128.378995] isert: isert_cma_handler: failed handle connect request -12
[  130.668362] infiniband mlx5_0: create_qp:2783:(pid 81): Create QP type 2 failed
[  130.705869] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  130.777306] isert: isert_cma_handler: failed handle connect request -12
[  132.671161] infiniband mlx5_0: create_qp:2783:(pid 86): Create QP type 2 failed
[  132.707807] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  132.778867] isert: isert_cma_handler: failed handle connect request -12
[  132.810653] infiniband mlx5_0: create_qp:2783:(pid 19): Create QP type 2 failed
[  132.845691] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  132.912706] isert: isert_cma_handler: failed handle connect request -12
[  134.681936] infiniband mlx5_0: create_qp:2783:(pid 83): Create QP type 2 failed
[  134.718932] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  134.788804] isert: isert_cma_handler: failed handle connect request -12
[  136.678428] infiniband mlx5_0: create_qp:2783:(pid 86): Create QP type 2 failed
[  136.715859] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  136.785058] isert: isert_cma_handler: failed handle connect request -12
[  136.817414] infiniband mlx5_0: create_qp:2783:(pid 727): Create QP type 2 failed
[  136.854583] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
[  136.922975] isert: isert_cma_handler: failed handle connect request -12


Client:
$ iscsiadm -m discovery -t sendtargets -p 172.31.0.6 -I iser
iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
connection failure
iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
connection failure
iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
connection failure
iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
connection failure
iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
connection failure
iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
connection failure
iscsiadm: connection login retries (reopen_max) 5 exceeded
iscsiadm: Could not perform SendTargets discovery: iSCSI PDU timed out


Thanks,
Kamal

