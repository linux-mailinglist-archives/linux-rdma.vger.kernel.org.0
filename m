Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C465DB45
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjADR3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 12:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjADR31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 12:29:27 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8721BF
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 09:29:26 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id b81so17050189vkf.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jan 2023 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1qkpx8NqkvB2wucoL8n0d1YgQioawYLgUddBD4b1tmI=;
        b=IeC9jnRgfFlcjY3WcMaxLxaTy7+s6iELlZpWMXOzKu/lbLUkrCJDlzwatvMR7PifcE
         FfPMN+RK2bsSoMmYPW/dBZqJqn7e70fBSxKVQsDKPFMEGeyHqbKaHktVgONrUEc7UvQ1
         DRwkV3r3mv4x9xd3w1Vm1S7SjxDEgqhRqdfDsxYex7R35YcZjGYh9w+WIocZCv/m/HXS
         xBBb1nr/cKKIbDZLxMqG5u+z3S71/Jn+JvVUWUTxOtpoeKmBR2oak3AZpKDsUeo4+8f+
         GHzUUeeuZt8hSa0UN28ZYDAbI+pTL/PsmXhkYpZZQaAR0V1MRwBCt2knOdHYony8/OdC
         AcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qkpx8NqkvB2wucoL8n0d1YgQioawYLgUddBD4b1tmI=;
        b=vYVRH5EukHo7zHrguRMZaooJgL84SecdlErgHbLT3qltZ/nUE/WJwbuJiC78HMpFcC
         JOLQoaoRyOL4qbdfam/lb7ANnKIEqNjDE/DwogvFBNmZ71mDzpOf4LN7i966k1TPge8U
         NLoxyrCETouCla1e/l5/FcBGxsOcT8AANQU8aPSX72jLNOlKg3Jgb7MlxX+oe7cLZVKn
         01NRg1xtyzqZAmGnNxQ5qeei0BiCxUelH8mDGaO2K2au88pRdK6hkw0Pe5h45zjSPPHu
         Vqear0I1QpvvMsA7XxlmRddm6vPt1KP7IYt+E4saLJRgv82qucENs0tZ69wIhE3reuLk
         p+Eg==
X-Gm-Message-State: AFqh2kovz36jFHgkc8NidQKJJ8+QQQAS0xBUG2UEuchi+blpt1lhnjEC
        XNZHYv8Tiz2uiuIkwQUhzqNfDvC22w0/V2Gx
X-Google-Smtp-Source: AMrXdXulBNgdyVKhLmQrgtiaAgptYE7DtTGCwvy6aMFZlrI1RCdt2oqSHJmRX9z1NHWRyP3dhHSYrQ==
X-Received: by 2002:a1f:2b82:0:b0:3bd:3a9f:be92 with SMTP id r124-20020a1f2b82000000b003bd3a9fbe92mr20217800vkr.1.1672853365379;
        Wed, 04 Jan 2023 09:29:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b006fec1c0754csm23869169qkm.87.2023.01.04.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:29:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pD7Zs-0027t5-2C;
        Wed, 04 Jan 2023 13:29:24 -0400
Date:   Wed, 4 Jan 2023 13:29:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Haywood <mark.haywood@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: buildlib/pandoc-prebuilt
Message-ID: <Y7W3dASpXM7/br4i@ziepe.ca>
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
 <Y7TF8EK/PXiwKRwU@ziepe.ca>
 <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 04, 2023 at 11:05:53AM -0500, Mark Haywood wrote:
> 
> 
> On 1/3/23 7:18 PM, Jason Gunthorpe wrote:
> > On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
> > > I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> > > and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
> > > intentional?
> > ?
> > 
> > It looks OK:
> > 
> > $ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> > $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
> > rdma-core-44.0/buildlib/pandoc-prebuilt/
> > rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> > rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> > rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
> > rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
> > [..]
> 
> I can't explain it. The one I pulled yesterday doesn't have them:
> 
> $ tar -tzf rdma-core-44.0.tar.gz.orig  | grep -i /pandoc-prebuilt
> rdma-core-44.0/buildlib/pandoc-prebuilt.py
> 
> The one today does:
> 
> $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt | less
> rdma-core-44.0/buildlib/pandoc-prebuilt.py
> rdma-core-44.0/buildlib/pandoc-prebuilt/
> rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> [..]
> 
> I am sure it was user error on may part, though I don't see how. Regardless,
> it's fine now, thanks.

There is a second link:

https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz

That does not include the pandoc, perhaps you downloaded it by
mistake?

I don't think the releae tar file changed at least, it is generated by
a script

Jason
