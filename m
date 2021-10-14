Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1587C42DEFD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhJNQRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJNQRF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 12:17:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B577BC061570
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 09:14:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o204so9081510oih.13
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Q8HhdBt1Lqa7vXxk7AXPd+nOlUGrpVwEUOUenCfs+Rc=;
        b=SbqqoF60liyYjX714kp4uaCxmSZeNmm66FczfRRS/tN2X29kKvU5T5AAQg6W2LbMnb
         viEjxuZ0w8EguXAZNYI70m2V9ETB3UnOn9pwVaxOCM/dyUpi/YDXbSv+STV89H3YZ2QW
         cXZ1tI8yFmY/ADMhTJjRO58/TSPVIlAygl5YFGZ5psjUdqyeXrCN2vu4b/ifqt4QyLrV
         uzlhGf9q++fh0er6M/jmyx6u+vhrx0zOQhlVjEyDYquR7+C5kchy+PP1TBBYcmLLcZl6
         SmmXT2vqfWL1KIPRwf2Eu7lXtV/Hd951zqTVrwdFFAFG4B9NGZn/n6GaD2WTTFDNyavi
         aq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8HhdBt1Lqa7vXxk7AXPd+nOlUGrpVwEUOUenCfs+Rc=;
        b=tnUgJJTqQPfckr3CR6e691BpNgwynWbdmlFjW367t3HtAhiWTwEBwBM4aLYFuamX0N
         RMIpflSmnd8V1aMTwOen33KA5DhTAQd14Vdl0LhmUCELhOTwlh99irW+McpuqfJtJTII
         QfazpmZoLmwLJSJaFTBYsEfob+B11Yeea8YMvqEoyLl/OLb1elMoI99jAZwCGvokVBwn
         3tiGFIQ+pe5WzXXL6fqJewD7d8bCKsjrJppt4PzdA8V3649RcsE6zgASCKTRsz2SqGzu
         nmNOUBNfrhg/rB0LMK/Ki9W99hpZnHHBcvK7Mso6c5ho3Iiq16Am5bbr/VYAQHfEEgAG
         nEsQ==
X-Gm-Message-State: AOAM530RtNr+7EPB9wGNC6vukYc5aIx2xn7xUhrt04ntVn5CRlhhYPFh
        aqPj3lIJ0Ab+q3zdhqJxy+thckdT1lQ=
X-Google-Smtp-Source: ABdhPJyZ48SHGa8cu9j1oRocuo5DZ9XHdJABhboAQKlKm7JqyRsr4WMknvpa/feWVV7JyShfahVG0g==
X-Received: by 2002:a05:6808:11c8:: with SMTP id p8mr13804304oiv.72.1634228098604;
        Thu, 14 Oct 2021 09:14:58 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:487b:eaab:6345:1a9? (2603-8081-140c-1a00-487b-eaab-6345-01a9.res6.spectrum.com. [2603:8081:140c:1a00:487b:eaab:6345:1a9])
        by smtp.gmail.com with ESMTPSA id j6sm517637oot.18.2021.10.14.09.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 09:14:58 -0700 (PDT)
Subject: Re: Bad behavior by rdma-core ?
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <414e99de-9b1b-edcc-4547-f8002adecd69@gmail.com>
Message-ID: <3bda5d0b-dc04-7640-b832-867858ef7a12@gmail.com>
Date:   Thu, 14 Oct 2021 11:14:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <414e99de-9b1b-edcc-4547-f8002adecd69@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/14/21 9:57 AM, Bob Pearson wrote:
> I have been chasing a bug in the rxe driver seen in the python tests (test_cq_events_ud).
> The following occurs
> 
> 	The first time I execute this test it creates two AHs which are allocated by
> 	rdma-core and passed to rxe_create_ah. The test attempts to destroy them
> 	(i.e. rxe_destroy_ah is called in the provider driver) but rdma-core does not
> 	destroy them (i.e. rxe_destroy_ah is not called in the kernel).
> 
> 	The rxe driver saves the AV state and some metadata for these AHs and keeps it
> 	since it thinks they are still active.
> 
> 	The second or third time I execute this test two new AHs are created by
> 	rxe_create_ah but the memory passed in from rdma-core is the same as the first
> 	test. I.e. it has recycled them but they are still active in the driver so
> 	the result is chaos.
> 
> Somehow rdma-core thinks it has destroyed the AHs but it does not call down to the
> driver. This only occurs for AHs AFAIK.
> 
> Bob 
> 

The cause seems simple enough.

In uverbs_cmd.c ib_uverbs_create_ah() calls rdma_create_user_ah() which
eventually calls device->ops.create_user_ah() or device->ops.create_ah().

But ib_uverbs_destroy_ah does *not* call rdma_uverbs_destroy_ah() it just
deletes the object.
