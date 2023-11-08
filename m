Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792767E5EF5
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjKHUIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 15:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHUIt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 15:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C558F1BD5
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 12:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699474081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16Hy8wyBf+G3uKv9pBcTNzd8i05xbnRDmDtUy7/dfyQ=;
        b=fS/kMcie3lGSR/mt+ab7yKRVdnKD5sNUfpjc6lOV5TvQTcGEY0erfzK6d7fNgaqQTtGsVl
        WkthIZitoMc4UebST9Smx7lzFOCTMf0QQ11894Nbai3vYfpsRrCIlU4tFvd6qmEVsg16DU
        K9TxszzO/tcghY0nQe3/qZpCi/zX8ao=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-XKTpIh4SNxiv45Ubs7LuhQ-1; Wed, 08 Nov 2023 15:08:00 -0500
X-MC-Unique: XKTpIh4SNxiv45Ubs7LuhQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-778a32da939so8452885a.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Nov 2023 12:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699474080; x=1700078880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16Hy8wyBf+G3uKv9pBcTNzd8i05xbnRDmDtUy7/dfyQ=;
        b=tRyTXknLZUt3QTCRLXeSLQjh4EGZlKIXP+OV78crxRihLJYqum659TyRVO0j/DY96x
         IsiKa0uf0TKbSPsu/0FCOb+u3tZ2Hv9gtEkyPUMLggWfCfO+Q1C/mtbG9JmlWc/6P4GA
         WEGAwJQPnCZQhp7eXYURb3DvMrNaJZpk4oluNZjIhLZ2bGcXsgg5G8vX3S9d9rt7PO0k
         lOaOjWWKq29GJRDZc1KtfaBz8VwSYHPYIdLQerMnc6ox/gYMX3K/aHTPymn63/ltIOIe
         D6ygIcUK91D0QB6eqa1neIzQ0BTsLgE9yCrx1rruolFjn0Cm15UnHDCa4G2k8rIlr2NV
         unTA==
X-Gm-Message-State: AOJu0YwORNDmlZe/MNViqEj9NPGs9RyLoraGAzgXrclWIGsHnFaFPAMC
        c7uyWD8i4zV6OlMYOfNiXsE9P5nSujWeOBkeIuJ4pUz0rC1SWfJqEBqFVnewWnL4+UCLZ6swHYo
        VaMX/JkPxwF2PWEtNHPAOqJTzZzlA7w==
X-Received: by 2002:a05:620a:31a7:b0:77a:4466:354c with SMTP id bi39-20020a05620a31a700b0077a4466354cmr3162007qkb.49.1699474079814;
        Wed, 08 Nov 2023 12:07:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsj1JMt0/n3JUFWnIHVGAAefOJa741d0O5jAWVE35djki0d7cr8M0xAkRN0SoxiXAHhiffNw==
X-Received: by 2002:a05:620a:31a7:b0:77a:4466:354c with SMTP id bi39-20020a05620a31a700b0077a4466354cmr3161983qkb.49.1699474079455;
        Wed, 08 Nov 2023 12:07:59 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a0e8600b00777063b89casm1388733qkm.5.2023.11.08.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 12:07:59 -0800 (PST)
Message-ID: <27ebfe1ffb5b9e1983466f6ad3a1726b66fc0799.camel@redhat.com>
Subject: Re: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
From:   Laurence Oberman <loberman@redhat.com>
To:     Mark Lehrer <lehrer@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "busch, keith" <keith.busch@intel.com>
Date:   Wed, 08 Nov 2023 15:07:58 -0500
In-Reply-To: <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
         <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2023-11-08 at 12:57 -0700, Mark Lehrer wrote:
> > [=C2=A0 286.547112] nvme nvme4: Connect Invalid Data Parameter, cntlid:
> > 1
> > [=C2=A0 286.555181] nvme nvme4: failed to connect queue: 1 ret=3D16770
>=20
> It looks like the admin queue pair (0) worked at least.=C2=A0 The code
> path
> for the two is a bit different.
>=20
> This error sounds familiar.=C2=A0 I wonder if there's an error code 16xxx
> cheat sheet out there.
>=20
> We recently had to downgrade a ConnectX firmware version to fix a
> similar issue, but on a CX7.=C2=A0 I can't remember the firmware versions
> involved but I could probably dig it up.
>=20
> Have you tried TCP mode?=C2=A0 Whether TCP works or not will be useful
> information for debugging.
>=20

Hi MArk

I landed up changing the default kato from 5s to 30 and its working now
We don't jump ship too early anymore and it connects fine.
See prior response where I answered my own message

diff -Nurp linux-5.14.0-284.25.1.el9_2.orig/drivers/nvme/host/nvme.h
linux-5.14.0-284.25.1.el9_2/drivers/nvme/host/nvme.h
--- linux-5.14.0-284.25.1.el9_2.orig/drivers/nvme/host/nvme.h	2023-
07-20 08:42:08.000000000 -0400
+++ linux-5.14.0-284.25.1.el9_2/drivers/nvme/host/nvme.h	2023-
11-08 14:16:37.924155469 -0500
@@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
 extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
=20
-#define NVME_DEFAULT_KATO	5
+#define NVME_DEFAULT_KATO	30
=20
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0


I will wait for Sagi and Keith and then send a patch
I had the wrong email for Keith

Thanks a lot
Laurence

