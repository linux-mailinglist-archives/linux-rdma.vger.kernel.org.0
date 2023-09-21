Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648A67A961D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjIUQ6a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIUQ6S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 12:58:18 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E273186
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:57:42 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a505727e7eso495427241.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695315446; x=1695920246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aj1zPvv2FItd5VuImcsJyg+MhOvALycMYrSdg0qvbNg=;
        b=Uv0N4xwkAd/3dZ0Dvvts5DelVvQx2gveMtOY5yibtLKDHXLBPTd3XTH+8YOSVG4una
         WYQqCpypBsYjQ1oZctyefzXrpiJBinUHkLiN9NQOtMDh8CffgIOUTYKv/TNXLsipn4MR
         A9P2avjW6SYWm+2T/gsU/ZIyT3yit5ue+Bt+PCr5I4DNup7nz2QH105Txl4iiv7t8e2m
         8798oUZKGShAFnx6ffLIR9TC73UtW+wLnSBeai+d0dIIHRsz3IB7dAC4Vq8u/tg9iPyd
         z9echE2Nx4jynaT/d+ZWF4S/YtIKDfdv719OtIg15e3aXlgKj6LdZ9YjvaJEJea/zQFD
         rv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315446; x=1695920246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj1zPvv2FItd5VuImcsJyg+MhOvALycMYrSdg0qvbNg=;
        b=T57iNxoXGSFExRbFkcRGRRQYey2LDyfF0ZE5wJaU1CRtavIFNB24q+KQ56u7Zs8np0
         bxp3i1v6bp+QJAiklpk1VN+uVeFssFRup1jnz3I8Q5xdqv3W/+z8VVIhyqAXm+50z9Jz
         8kaaVmdJE+FKCg+8/FGdPLB2wXaNZbivvNu3iu926hFWtTH/lwZBSLjEcJts21jQ2xvc
         ToKyq9/iBrB3NFeFe6ibu5bephwp9Ubbffz8jZgJymcDCbVq2V3JjGYSk3ABDw65nS90
         QagkfTnMffzMlDn4Eg747dhjKN6vNyl6ZNdEVTs9DSWlk/5oghjug8JD85JnyWq436CP
         KL/w==
X-Gm-Message-State: AOJu0YyU+ARXDcBdesDCjqVHfsUlGTiFBO9x3V8VuubXjeJ/n2Sm2ZqP
        2zzxCNtBnPde83XFo+Qx82YRjDgQt2oqnSdXeKo=
X-Google-Smtp-Source: AGHT+IHbI8AEVfZgjWAuFmaHbINmEu1PodGQn4DmqAe0JmUDJQegpyqGsXCPxuEX3wPXFT17AD3F2w==
X-Received: by 2002:a05:6a20:6a27:b0:152:6b63:f1e7 with SMTP id p39-20020a056a206a2700b001526b63f1e7mr6948476pzk.1.1695314946547;
        Thu, 21 Sep 2023 09:49:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id l21-20020a62be15000000b0068fe5a5a566sm1647037pff.142.2023.09.21.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:49:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjMrQ-000SGu-5J;
        Thu, 21 Sep 2023 13:49:04 -0300
Date:   Thu, 21 Sep 2023 13:49:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maxim Samoylov <max7255@meta.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH] IB: fix memlock limit handling code
Message-ID: <20230921164904.GW13795@ziepe.ca>
References: <20230915200353.1238097-1-max7255@meta.com>
 <20230918120932.GC103601@unreal>
 <f83fcbe0-308c-4485-ad96-ede52608e141@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83fcbe0-308c-4485-ad96-ede52608e141@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 21, 2023 at 04:31:44PM +0000, Maxim Samoylov wrote:
> Furthermore, it also bumps per-mm VmPin counter over and over without
> increasing any other memory usage metric,
> which is probably misguiding from the memory accounting perspective.

pinned memory accounting doesn't really work sanely in linux. There
was a whole dicussion about it that never concluded.

Jason
