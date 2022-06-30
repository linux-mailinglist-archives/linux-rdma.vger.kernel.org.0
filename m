Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272AE56231E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiF3T25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiF3T24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:28:56 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A631141619
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:28:55 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso605430fac.4
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UohUyuirfwwaIddSwqVXfcvohEM3cG/y5DKPfcIiHqA=;
        b=BxhxkHxqa0wsRgiVvhmyrsdg1Oa1uaR3EWh/6Ufj3S2ycIDA8fGvfuHm3PSeENw/re
         5T25/FpL77xCddRlmZsG65NNSuR1J8W5IhgFnZzLdYdS32DQk9JwTUA0kArsHXuh9Vvz
         1J8OFURD9LbLIbfMf/Awfn+by9ob/YDe0XCdP0YK+0u2cyA9+fP6IZElCcrBbx7l9Kza
         pk7gRkcFLFovqU3LwF65S0DxYjUuY+Ozy+A+EoL/ASPz1yfplIzrfrqjA6/FhbY1zKTi
         SU13s638I4nclQv8rDiGCY0NqYXU8STiK9bDyKHQugIt3OVWAYccuYH5ovEhCRNGnDJJ
         Cyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UohUyuirfwwaIddSwqVXfcvohEM3cG/y5DKPfcIiHqA=;
        b=CSQWYDwqHcJJQoEJ47Ixq7XbjnDk/7IkrTITX4OTX5BlpAW624qkHXKhsA9Wc2SysT
         SHGipIMSk9tFIaFL5h9alG11BGgOO9LquaIBQJUqMaamKloO1mVTJ0nTxqQc+yCP9i3u
         FxGcAa3lKG/ujA+Sd3Vj4/mfiLuU86UgXGiM2YQ0Fv2ug10ydDrnqIw1R9UdalKnm+4k
         cug1mG6fazbjrCIliYosjuUZHVJWyRYhNiCR4LT1wUA7muwD+fRWLaj4aST0d5ltQ6pY
         Yz10zCAM3mx/EIHTSCPBNBpOOpDeRkzDsye2mONWLeuq789Oa7jGUe38DVa5m1kl15c7
         xCCg==
X-Gm-Message-State: AJIora+8FFQo81+oI5DvPu3TP4daxoleJDJZmaMgiLe0+vGa8URCHElv
        87roGS/TJTxzxflXqK40kmU=
X-Google-Smtp-Source: AGRyM1svQ0vJh/FXjg2UEMSCs2T4wwuLcrAyLKZfzrkCHM8na4WBIwheSLjLEpSPqRmTCEDuny7o8Q==
X-Received: by 2002:a05:6871:93:b0:fe:23b6:6efb with SMTP id u19-20020a056871009300b000fe23b66efbmr6212612oaa.201.1656617335118;
        Thu, 30 Jun 2022 12:28:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e895:24ff:51a7:a632? (2603-8081-140c-1a00-e895-24ff-51a7-a632.res6.spectrum.com. [2603:8081:140c:1a00:e895:24ff:51a7:a632])
        by smtp.gmail.com with ESMTPSA id l16-20020a056870f15000b00101bd4914f9sm13400083oac.43.2022.06.30.12.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:28:54 -0700 (PDT)
Message-ID: <49cdb36d-3710-bdcd-7b8c-5edfeb93b36d@gmail.com>
Date:   Thu, 30 Jun 2022 14:28:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 0/5] Fix incorrect atomic retry behavior
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
References: <20220606143836.3323-1-rpearsonhpe@gmail.com>
 <20220630185224.GA1055414@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220630185224.GA1055414@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/30/22 13:52, Jason Gunthorpe wrote:
> On Mon, Jun 06, 2022 at 09:38:32AM -0500, Bob Pearson wrote:
>> Restructure the design of the atomic retries in rxe_resp.c modeled
>> on the design of RDMA read reply. This fixes failures which
>> occur when an atomic ack packet is lost as observed in the
>> pyverbs test suite with a patch to randomly drop packets.
> 
> Applied to for-next
> 
> Thanks,
> Jason
Thanks.
I think this will commute with the other fixes I just sent. If it doesn't I can rebase them.
Bob
