Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75668A235
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Feb 2023 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBCSrW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Feb 2023 13:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBCSrU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Feb 2023 13:47:20 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DF49A829
        for <linux-rdma@vger.kernel.org>; Fri,  3 Feb 2023 10:47:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r9so4907530oig.12
        for <linux-rdma@vger.kernel.org>; Fri, 03 Feb 2023 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9vLlcLIzkLhQq7ZFKGvz2guLCfvFTBGx2ygCe4aLvo=;
        b=LEfP6TQNySPiN+QdIiFl41SKcaqz+fYGzWCmUi/QZNI5bs8Aoy7UrXbb49lr3o5Leq
         nRGG4cZv8KFfo49MjfPfRh7EWkYIoP/fozfBrmo13RUpuiCs0GWDub23rPPv++z7erSV
         PVE8yM5Lky2nsx1ceHNOZQTmuXbFlwkdmY6JqEAYtQXw772kCGKNllsXyTY3PzT+8tbm
         +yHDiefdEfplYECFE45WonG/ulqFFVSaVuniVu39hQAqC8h+1k2NpjUyUYNY4Dh43a1J
         W7oGMBdpnJbxlQfZIdoN8IV5zpd1+QCQ9hvrr9cVkPIXwkr/dz9ofWDGvHyIVRg4oYDs
         Ci4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9vLlcLIzkLhQq7ZFKGvz2guLCfvFTBGx2ygCe4aLvo=;
        b=iHc5pOdCrN3w0JV3M6+0gLoc3jzpoGpQ16o3zY3uGSIBpgpgWvnhvBHJVCnyCPP22I
         FQZsNZLF7po+TNOcqdBiRMlls8h8v587lDSWIX0IpaoU2+KjPT2Le3xJa4/rpcdAryuU
         wlCkYa+3Y28974DEDoANCBE3L+X6PQQV99XoD32ZKlf+snnLA4iH3/9Wx3x49xmlTiWt
         RmLdNE3AzlJgOYzpMV3ZBBD8basDXpsMulcoCHoHQn+vCl8KhvCxPmmy1jiMTv4uU9nm
         Rg4zCjLVVwZ4MSuCmaXHRR9xY/TNDd8aLh9BM/qNxTQVO8ncfSRhm287wW+zGbIDGWRJ
         Uvmg==
X-Gm-Message-State: AO0yUKUccEspp4GNZ/KnLGCmvbqkkIaOQEgFDxrhnO/QnpejBLxZ/EbK
        89yyeWICWOcNi6UdBCcc5fE11TQjeHctdg==
X-Google-Smtp-Source: AK7set9EOERCnch8Yd3mbOhJmT5VwWoIMfBDkzy4lcSrMr/KprF1cAyUaTSFlXAzA8Nfre/hLdCJ/g==
X-Received: by 2002:aca:a907:0:b0:36f:9de:40c2 with SMTP id s7-20020acaa907000000b0036f09de40c2mr4556186oie.2.1675450038573;
        Fri, 03 Feb 2023 10:47:18 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id t16-20020a056808159000b00369ec58932csm1068626oiw.45.2023.02.03.10.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:47:18 -0800 (PST)
Message-ID: <cd9fda7b-3613-c5a4-7dc9-95433cf4dee4@gmail.com>
Date:   Fri, 3 Feb 2023 12:47:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
 <TYCPR01MB84555DAEE984472F7B209B80E5D79@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB84555DAEE984472F7B209B80E5D79@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/23 04:00, Daisuke Matsuda (Fujitsu) wrote:
> On Thu, Feb 2, 2023 1:43 PM Bob Pearson wrote:
>>
>> Currently the rxe driver does not handle all cases of zero length
>> rdma operations correctly. The client does not have to provide an
>> rkey for zero length RDMA read or write operations so the rkey
>> provided may be invalid and should not be used to lookup an mr.
>>
>> This patch corrects the driver to ignore the provided rkey if the
>> reth length is zero for read or write operations and make sure to
>> set the mr to NULL. In read_reply() if length is zero rxe_recheck_mr()
>> is not called. Warnings are added in the routines in rxe_mr.c to
>> catch NULL MRs when the length is non-zero.
>>
> 
> <...>
> 
>> @@ -432,6 +435,10 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
>>  	int err;
>>  	u8 *va;
>>
>> +	/* mr must be valid even if length is zero */
>> +	if (WARN_ON(!mr))
>> +		return -EINVAL;
> 
> If 'mr' is NULL, NULL pointer dereference can occur in process_flush()
> before reaching here. Isn't it better to do the check in process_flush()?
> 
>> +
>>  	if (length == 0)
>>  		return 0;
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index cccf7c6c21e9..c8e7b4ca456b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -420,13 +420,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>>  	return RESPST_CHK_RKEY;
>>  }
>>
>> +/* if the reth length field is zero we can assume nothing
>> + * about the rkey value and should not validate or use it.
>> + * Instead set qp->resp.rkey to 0 which is an invalid rkey
>> + * value since the minimum index part is 1.
>> + */
>>  static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>  {
>> +	unsigned int length = reth_len(pkt);
>> +
>>  	qp->resp.va = reth_va(pkt);
>>  	qp->resp.offset = 0;
>> -	qp->resp.rkey = reth_rkey(pkt);
>> -	qp->resp.resid = reth_len(pkt);
>> -	qp->resp.length = reth_len(pkt);
>> +	qp->resp.resid = length;
>> +	qp->resp.length = length;
> 
> As you know, the comment above this function is applicable only
> to RDMA Read and Write. What do you say to mentioning FLUSH
> here rather than at the one in rxe_flush_pmem_iova().
> 
> Thanks,
> Daisuke
> 
>> +	if (pkt->mask & RXE_READ_OR_WRITE_MASK && length == 0)
>> +		qp->resp.rkey = 0;
>> +	else
>> +		qp->resp.rkey = reth_rkey(pkt);
>>  }
>>
> 
> <...>
> 
Daisuke,

The updated patch no longer sets mr = NULL for flush. This check is mainly to defend against someone changing
it again in the future and is near where mr is dereferenced. You are correct about the comment I can change it.
Will give it a day or two to see if anything else comes in.

Regards,

Bob Pearson
