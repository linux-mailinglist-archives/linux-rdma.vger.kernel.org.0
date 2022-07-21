Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE657D4C7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiGUU2t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiGUU2s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 16:28:48 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5628E6EB
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 13:28:48 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10d83692d5aso4016079fac.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KPB4JaD3Bkw4/9zmgYAEyWnMLi96kjYon6db+fv+Cnc=;
        b=BgGLOdMJDXw7JhL4jn3JmE0IyHBzVqGcnHpCGYMcrxvzbx3zaQ34LYMExVwoQvVd9/
         UjIE9mILi2UZ44p+ViCGs/FVTuErab4JMEFS9i1sVwhmLE+Ap0tKlWpo4atzIET4vxks
         IXAFqw9d+NKW5wzJNC6DfffupXfLtewoxO9AdiMKGn6WWJxn+ECVr6FHNP57Vnl9wikD
         ve2anz6iM+b2rmT3+gxEXo16wlyEEMuDH80xWow00teZdVRBtGuelUAszeLg53phlI7P
         0gjCLyzgABOum3svfjK2dgPa7gc6/mVa2b+J1ysEIVtulhzs/G+AIdXhfBZ9itURMswx
         ehmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KPB4JaD3Bkw4/9zmgYAEyWnMLi96kjYon6db+fv+Cnc=;
        b=ItHC3kwZerFBy2yzuviyHP1oxXSKmQEi3napMEjbfxULm+E3D+owXLTMowCk1iUpQs
         jjzOLSS59OBcCgVqS6707Tu+ffYRdCjxZcUAlQHjtXf8Yb6rk3pQ5YFrDNukZfEBDTth
         A9vvYNQuOi0SGkPdlXQwNu61PpnrpukdWXsc+koThpU112vRb34T3AVFy1rdaaSPsAvr
         fT7IgHOANM/16Jlajl9ha/m7ILPHrO/ilO+oL8kFLxXqxYCBdqgnpTTp0T1fbTtytDeZ
         63AJu3jQsvOfNOHTW3zkzcghUvtElBVg+sbbVHgAgkeRe3pzMdsKfy2TK/w/5LGy6Xcq
         27Gg==
X-Gm-Message-State: AJIora9GFWw8MoQnFfqW5oQljZDw1lRv0Db+0SAozDUnyoPSTdI77TKN
        zmY/6AP660A0b3pvI6WjtggmTSWXExM=
X-Google-Smtp-Source: AGRyM1tj0RFgB9sMhylgd4e4CmHUxXcjyKzZrp2Ne2Y55yaXHmKh0iEVtil7y1/nRv9NNlCfhdnVEw==
X-Received: by 2002:a05:6870:8a0e:b0:10c:1abf:6cbe with SMTP id p14-20020a0568708a0e00b0010c1abf6cbemr53327oaq.133.1658435327631;
        Thu, 21 Jul 2022 13:28:47 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:26e5:db00:e7ca:8ba1? (2603-8081-140c-1a00-26e5-db00-e7ca-8ba1.res6.spectrum.com. [2603:8081:140c:1a00:26e5:db00:e7ca:8ba1])
        by smtp.gmail.com with ESMTPSA id h130-20020aca3a88000000b0033a6bfdc5adsm1050408oia.36.2022.07.21.13.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 13:28:46 -0700 (PDT)
Message-ID: <bdd603f8-344f-dfec-29ee-96a512c35db0@gmail.com>
Date:   Thu, 21 Jul 2022 15:28:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix error paths in MR alloc routines
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     lizhijian@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220715182414.21320-1-rpearsonhpe@gmail.com>
 <20220721191525.GA9189@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220721191525.GA9189@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/21/22 14:15, Jason Gunthorpe wrote:
> On Fri, Jul 15, 2022 at 01:24:15PM -0500, Bob Pearson wrote:
>> @@ -173,12 +172,11 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>>  	void			*vaddr;
>>  	int err;
>>  
>> -	umem = ib_umem_get(pd->ibpd.device, start, length, access);
>> +	mr->umem = umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>>  	if (IS_ERR(umem)) {
> 
> So this puts an err_ptr into mr->umem and then later the cleanup:
> 
> 	if (mr->umem)
> 		ib_umem_release(mr->umem);
> 
> Will not like it very much.
> 
> I'm OK with the idea of initializing structures that are cleaned up by
> their single master cleanup, but you have to do it in a way that
> doesn't put corrupted data into the object..
> 
> Jason

I fixed this patch but it collides with the map set revert Li
sent in.

Bob
