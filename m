Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7512F188
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 00:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgABWL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:11:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36057 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgABWL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:11:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so3932362pjb.1;
        Thu, 02 Jan 2020 14:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8U820VJKJADL/lcD+292oHhknEe+PAQoByMDN3CKqzA=;
        b=Uidbk4x6wW1C5MGpJZoKE06cu/mx65SGaphn3ppdwpLL/ssKWVBj7j/ZxUFR2SZgnB
         ojHCzbHSkV0GQ/BVFR5u5Dkvg96yqPOe6YtaxSQzTHt7LU2/GZL24Xoph2/leq5ehfOo
         QULC7AuCKrLC+qIH55YME0M7xDeLmJ14+hUTyyZdlxNt+OdoAwJEjD3rufp30Dp7QMf9
         gpxI09h29Yp5pNjmOwWCmKTofs7bWw1Yh7qH7yPrQmmQGsJc/k8+HkwZalZsmU1yPCZo
         2EyWnn/ZdJo0yfaXRo3Pd2mjzWp2Rfet0ZWysizoL4IskG5DR1e9PCcAmKE4rhAPOaJn
         KFpg==
X-Gm-Message-State: APjAAAXAXpHBN0bJUm3w6vxVDhYA7oLdVHC0N0HVpT0wI4L3JhpAJiCK
        tp1cwaWKwr2keNkUHZb1xrU=
X-Google-Smtp-Source: APXvYqwoMkgpeootuaw0pMPB0p56Bzg9+JCP4XKyIgTMunhwec+vXendh17YyiIvtwEKQQi5xcoiAQ==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr22973659pjc.16.1578003087003;
        Thu, 02 Jan 2020 14:11:27 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c19sm68443664pfc.144.2020.01.02.14.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:11:26 -0800 (PST)
Subject: Re: [PATCH v6 13/25] rtrs: include client and server modules into
 kernel compilation
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-14-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <81414f0d-ee6e-9477-ef85-12476faa257d@acm.org>
Date:   Thu, 2 Jan 2020 14:11:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-14-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +config INFINIBAND_RTRS
> +	tristate
> +	depends on INFINIBAND_ADDR_TRANS
> +
> +config INFINIBAND_RTRS_CLIENT
> +	tristate "RTRS client module"
> +	depends on INFINIBAND_ADDR_TRANS
> +	select INFINIBAND_RTRS
> +	help
> +	  RDMA transport client module.
> +
> +	  RTRS client allows for simplified data transfer and connection
> +	  establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
> +	  READ/WRITE semantics and provides multipath capabilities.

What does "simplified" mean in this context? I'm concerned that 
including that word will cause confusion. How about writing that RTRS 
implements a reliable transport layer and also multipathing 
functionality and that it is intended to be the base layer for a block 
storage initiator over RDMA?

> +config INFINIBAND_RTRS_SERVER
> +	tristate "RTRS server module"
> +	depends on INFINIBAND_ADDR_TRANS
> +	select INFINIBAND_RTRS
> +	help
> +	  RDMA transport server module.
> +
> +	  RTRS server module processing connection and IO requests received
> +	  from the RTRS client module, it will pass the IO requests to its
> +	  user eg. RNBD_server.

Users who see these help texts will be left wondering what RTRS stands 
for. Please add some text that explains what the RTRS abbreviation 
stands for.

Thanks,

Bart.
