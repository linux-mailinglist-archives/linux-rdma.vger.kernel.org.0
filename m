Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6066942A9F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfFLPRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 11:17:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45052 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfFLPRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 11:17:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so18868704qtk.11
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJL2bHo8jZjiFX6Li1joOo21raCYmpj/UkhMPLByvQc=;
        b=UI1DK4fHe38lNg3vdOM0Er6Wz9RYEEVATUnV9Pjyg5v0XNlIimqjWy7Odj6Oa/GqA9
         wDrefvmrueqcJ897O0cejIuB9SpSOFDxjSQ2lRVWVbArTQIfi3NzTGe4VTv1nBKuwmVP
         OTy31Sbf4npitXBRs+N7hCdXh43K/DCDgVxjHUkGRtvZZrUg3VXgSbe+Ke9fVK9RdqNN
         1yN1oiFF9PhiEduVjUzgtm9n+6WP59wPFfd9zHVYCdff30C0F1BLLYL0vpvAO2b79kuv
         vPq1tPzu9j/Z8fp2IdCZoglqGkCnJVXubP17FXHp6c2yn76ezvUIH97q1AUsaXPKYUer
         bVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJL2bHo8jZjiFX6Li1joOo21raCYmpj/UkhMPLByvQc=;
        b=DJSzbCrWYxDHntl/hWXJtsz/Ti5j/J0V4DW+iJbYl8KKG+LyGFE8KqLJNf4mgYcs69
         vG91DSwmaKxvhnv5nQ4uqlKw4Xa1RTjZeckay0D6BRdRo4Ju+z0PUGBKqyhBYli1ZznY
         JhYmYlR9G7iHPGo/Cw/3YfkLWZyAXkNU/QSuLNF0K0h2mTU0LVY7Xms4dG0gQIzTYGkC
         nOGDkwTpIDbh2q0KePTgphaU+j5Yr/84YioIds+AesjXoGQuJJvIsq01bDwbGPC57n2t
         Efs2iAjLoXHvB1Zxhj8DPNmdFh4RU5627EDFq3+9B488UvcK7K/pZDSxp+jFhimVxz8r
         K22A==
X-Gm-Message-State: APjAAAW3W56/sgaH9zV1NUBdKC5qDvniXZtCV2N2OdZaQGvwba58kDZ+
        heCpI7rEErH/PO1IjNWA+1MHwlAo8y9ULg==
X-Google-Smtp-Source: APXvYqw5KT192XBl7G8Ca3LZhkl5/+42N/kNNUr1g+9BT2ccp8RedS3cs7zHYaNkoGvS6XpK6H7lQA==
X-Received: by 2002:ac8:6b06:: with SMTP id w6mr67114415qts.80.1560352659009;
        Wed, 12 Jun 2019 08:17:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm36772qta.58.2019.06.12.08.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 08:17:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb50L-0003uF-Qf; Wed, 12 Jun 2019 12:17:37 -0300
Date:   Wed, 12 Jun 2019 12:17:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: receive side CRC computation in siw.
Message-ID: <20190612151737.GH3876@ziepe.ca>
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 01:21:15PM +0000, Bernard Metzler wrote:
> Hi all,
> 
> If enabled for siw, during receive operation, a crc32c over
> header and data is being generated and checked. So far, siw
> was generating that CRC from the content of the just written
> target buffer. What kept me busy last weekend were spurious
> CRC errors, if running qperf. I finally found the application
> is constantly writing the target buffer while data are placed
> concurrently, which sometimes races with the CRC computation
> for that buffer, and yields a broken CRC.

Yes, you can't make any assumptions of the state of the target buffer
memory.
 
> To preserve performance for kernel clients, I propose
> checksumming the data before the copy only for user
> land applications, and leave it as is for kernel clients.
> I am not aware of kernel clients which are constantly

I think the storage ULPs could trigger this when using O_DIRECT.

Jason
