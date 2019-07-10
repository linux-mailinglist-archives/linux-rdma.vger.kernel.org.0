Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735A764CB5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfGJTXS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 15:23:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38374 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfGJTXS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 15:23:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so3708691qtl.5
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZ0h87ZvxZUh4mOq8Qfr7vbtEdk5hhypT8w9PB06WfY=;
        b=V9rOfXh3xV3LMg62cV2HZ98R/zh/glbp9TSc2kA3K+HRLGZbYpy5HMlXdnUq2mjmAo
         xT2KGwcM3YWQVX1fLc3MMCtQvXCuJwTCPrCN3zKbI1tbBQg6pdr0hdFcJnXW90xVtAI6
         Jalb3kSCKAK3iT6SwuJ7A2TtMWawvaC8YQFGngj//Bnv/gfkGPnG3BAilMZTbSWHL/hN
         bYaK1PNhvyBRXClwORYB9rJ97hV9jsSGRlfnF3u9faqhiCArWOw0o4KCw2vgBHF4TXkA
         hhI2SpDzRJS/MYkK6Yk4Xupjgp6SclByTq3WyhfTK8/CqWAnAczzvKer2oWnVE26uvDr
         MGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZ0h87ZvxZUh4mOq8Qfr7vbtEdk5hhypT8w9PB06WfY=;
        b=K9I2qvEpDXQnNbguJsVlbI0RcH/i+iXDa8alEgmlAFVoaadJKs60ZnhpR+VrlD+HAM
         i9z/uw+v54WKpk9XbbPn3CUlBfQg5IervJylBLMnxF7AQu/AebnTDCJb7RDBeWOEF0Vb
         lPPFjff9nL5KS7xim/RmbYqEC8t9ERj1YiI+03+sCOKHywjXZDZ/SQ3CQ9XCtczbxFb3
         lpNkdCJ/nY4rj/8+xpdzFsv80Td6IybfwbpHrvVGtsw4tN5S9AwXHVGHys/8n8LMq/aa
         Qt5lyN6NFYLU5D5gHPGqWTeZwOt2n473G+JJYIIlnCFPa2lliZDsLCSJul4qqPbC+Che
         pdVg==
X-Gm-Message-State: APjAAAXDTBhC+U/B3mcbUBz2XpVavKOZaR88v024hYYs3VZgn2L4a6OO
        B41jdRf1uyoXg1J/1byOyNaNpw==
X-Google-Smtp-Source: APXvYqzkB1SKogXnXAtday8hNvlSxRV4mqzQDnlxD27QKecizMugjiF6yA5JEuXLkYKHbWNZjoAdHQ==
X-Received: by 2002:ac8:42d4:: with SMTP id g20mr25472117qtm.78.1562786597227;
        Wed, 10 Jul 2019 12:23:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m44sm1747189qtm.54.2019.07.10.12.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 12:23:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlIBQ-0002d0-8b; Wed, 10 Jul 2019 16:23:16 -0300
Date:   Wed, 10 Jul 2019 16:23:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin Drung <benjamin.drung@cloud.ionos.com>,
        Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: failed armel build of rdma-core 24.0-1
Message-ID: <20190710192316.GH4051@ziepe.ca>
References: <156275862123.1841.4329369138979653018@wuiet.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156275862123.1841.4329369138979653018@wuiet.debian.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Benjamin,

Can you confirm that something like this fixes these build problems?

diff --git a/debian/rules b/debian/rules
index 07c9c145ff090c..facb45170eacfc 100755
--- a/debian/rules
+++ b/debian/rules
@@ -63,6 +63,7 @@ ifneq (,$(filter-out $(COHERENT_DMA_ARCHS),$(DEB_HOST_ARCH)))
 		test -e debian/$$package.install.backup || cp debian/$$package.install debian/$$package.install.backup; \
 	done
 	sed -i '/mlx[45]/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
+	sed -i '/efa/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
 endif
 	DESTDIR=$(CURDIR)/debian/tmp ninja -C build-deb install
 


On Wed, Jul 10, 2019 at 11:37:01AM -0000, Debian buildds wrote:
>  * Source package: rdma-core
>  * Version: 24.0-1
>  * Architecture: armel
>  * State: failed
>  * Suite: sid
>  * Builder: antheil.debian.org
>  * Build log: https://buildd.debian.org/status/fetch.php?pkg=rdma-core&arch=armel&ver=24.0-1&stamp=1562758620&file=log
> 
> Please note that these notifications do not necessarily mean bug reports
> in your package but could also be caused by other packages, temporary
> uninstallabilities and arch-specific breakages.  A look at the build log
> despite this disclaimer would be appreciated however.
