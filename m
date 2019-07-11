Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24B5654C0
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 12:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfGKKxP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 06:53:15 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40233 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfGKKxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 06:53:14 -0400
Received: by mail-ed1-f43.google.com with SMTP id k8so5327732eds.7
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vczTjXfQjpXE3D1vi5aQHLs08TESLBY34ooGwKEo+q0=;
        b=gZreH+Xl2nyQ74HQyivxjKPOejEbs8LxXPnY7TN6iLJR3keDcY5yxh3jgScA67cOuB
         clboUN0YPfCc31DGxfZhniCxx/B8PxehES+35i3XhfmVtW+GMQJrSkYhKGFCFLTLCHAW
         3MpWvveIKd7q9wvWODEeEBEIOh0WeZKLt3V3h5DUC4KTcue1KTCHd87KXP5RpIE4zfmY
         qh5woVktF9UF2ljZgg4wU1V9Wx9YPGzo6ourmtg2388h9e8KZM38GHtARpRZtVsHRq8s
         3nya1NHlzVH78WicUrnD7vrbPiJW8O9kneYa7U9Yxj4JSESM+bBIM1Pv53xIGjegoZx8
         ya9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vczTjXfQjpXE3D1vi5aQHLs08TESLBY34ooGwKEo+q0=;
        b=U91pIHmBkl0xf7jusR+pIRkpyCAGxHWjgLRgy27fKgpTKYOtWefaM9hcKefrL3u2TA
         i37QolrKdZT1i+qYqhll8UNX+8MWa1eDaCDVVndpLecdHfpBz5cH3gAp4EHfa7hvj/Z0
         xGURLP5mE3L7+eyEP9CyOGcxI7/u/7QpcJDBUjZKYUlLRHY8wCG2vw6hOMu5UCtg7WNU
         gs2eGmaudnGlF9FXDmZtUSPa38roP2Ss9t2+P8potv0hFOJ7fKQUddqxTAdQchgc97Vo
         QtAtGITFmE97q0a2hEuGN8l4TcC4h/rd9wHDBbYA+sRgupWU/RGbrVP9IxJOsMpAa3p0
         U06w==
X-Gm-Message-State: APjAAAXGtZfCMihGtkEf1EC+XRC0S6iLEB/HeHbXW2O/DTz8WVb249F9
        R00gfSeA2uh15fvzn8AR1SRocurirFA=
X-Google-Smtp-Source: APXvYqx8zDT3a5fBwC2jjxfRtT3+YyrvQmSqzy1dj+OrCJ8JbQA3+lDM8tm9/+zP6RrLj1VjLDUxMw==
X-Received: by 2002:a17:906:2ecc:: with SMTP id s12mr2595184eji.110.1562842392853;
        Thu, 11 Jul 2019 03:53:12 -0700 (PDT)
Received: from fiftytwodotfive ([2001:1438:4010:2558:9033:8018:ecb0:7d65])
        by smtp.gmail.com with ESMTPSA id f24sm1596964edf.30.2019.07.11.03.53.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 03:53:12 -0700 (PDT)
Message-ID: <7cf7ba06d08f25fb9ef6308e4451fafebc0abca9.camel@cloud.ionos.com>
Subject: Re: failed armel build of rdma-core 24.0-1
From:   Benjamin Drung <benjamin.drung@cloud.ionos.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 11 Jul 2019 12:53:11 +0200
In-Reply-To: <20190710192316.GH4051@ziepe.ca>
References: <156275862123.1841.4329369138979653018@wuiet.debian.org>
         <20190710192316.GH4051@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am Mittwoch, den 10.07.2019, 16:23 -0300 schrieb Jason Gunthorpe:
> Benjamin,
> 
> Can you confirm that something like this fixes these build problems?
> 
> diff --git a/debian/rules b/debian/rules
> index 07c9c145ff090c..facb45170eacfc 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -63,6 +63,7 @@ ifneq (,$(filter-out
> $(COHERENT_DMA_ARCHS),$(DEB_HOST_ARCH)))
>  		test -e debian/$$package.install.backup || cp
> debian/$$package.install debian/$$package.install.backup; \
>  	done
>  	sed -i '/mlx[45]/d' debian/ibverbs-providers.install
> debian/libibverbs-dev.install debian/rdma-core.install
> +	sed -i '/efa/d' debian/ibverbs-providers.install
> debian/libibverbs-dev.install debian/rdma-core.install
>  endif
>  	DESTDIR=$(CURDIR)/debian/tmp ninja -C build-deb install

I successfully tested a shorter version of this change on a Debian
armhf porter box and uploaded it as version 24.0-2 to Debian unstable.
Here is the pull request with all the packaging changes:
https://github.com/linux-rdma/rdma-core/pull/551

-- 
Benjamin Drung
System Developer
Debian & Ubuntu Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
E-mail: benjamin.drung@cloud.ionos.com | Web: www.ionos.de

Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim
Weiss

Member of United Internet

