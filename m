Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC26EDD80
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKDLJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 06:09:41 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42987 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDLJk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 06:09:40 -0500
Received: by mail-ed1-f45.google.com with SMTP id m13so6454442edv.9
        for <linux-rdma@vger.kernel.org>; Mon, 04 Nov 2019 03:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3pfSCqXB8BEX/vEjmF/nb7hoCru2rdIoJM05XVjJJCo=;
        b=A0s02b+lUG6yujbcKffgGVCZ0/N2sDv9yTuzSyaqyEuxKOWQmY0K3f9hAt5EetoM/S
         gN/2A3ML4Gw6Ol78bVPnfpkfc4VTMtHd7J7BVemW5Lk0GDsbUhlbiVOQhWuzeigwSq5g
         gVlpfpUyklbvXFDIWVTmnJhGummRrAdNrmDTm8BgysdYSpqN72N0Al0BxX1qHf/Z4NtA
         h0mGQcBXmWWdPRQ4wjIAqcZ+wWkdaN5m03Q74Fqv9jLfV1JRmP//Tx0SshsCql5V8RTW
         R6IGOdcFlIx8+JmmapLuarzN1uIffzgMYNS8mPe3cbQjPJlAvidykev1Yewh+6O74oA3
         CTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3pfSCqXB8BEX/vEjmF/nb7hoCru2rdIoJM05XVjJJCo=;
        b=Cb7C0Mn24XhDBBfPT7TQamt++TbaILG4ljhrEdMmtYA2WeSYdXVam5QAT6yM8B4oq+
         ugUCSgjlM/6rP5nbfCDXFfeDOPIuWW5PYERLqNsYPa072VaNW/9oGbFAOU5jnlo3IHck
         rhQ7N51P1yIrJ3ILecKFYVg+vTKUJcCswPFiv03CpK+PI+g7tsG6bptt7xjlsObeO44B
         nLUEYgP63AAiy2xCNMq6Bw2RV+YasAinNmXtBGXoiw8pTIKtDIix4d20gifgaKOb3Top
         ffhv+rhmrViHRBLbm+i6+5NLL8eVx0MzBzRyffNni6I7mK8T6HnWpm5dx+IFH4grCB7m
         HQyQ==
X-Gm-Message-State: APjAAAUZz8/HEwPJeB9QCp5MeSclMu0M0QehujqVEAm5tVBUSYpj+eYK
        ANYyQZLEHilw7YddbEKoKoqaXw==
X-Google-Smtp-Source: APXvYqzJHp3cBnQgGuU5zCiAVFyXel8Lbyn+qje+5EAbuutIVPCtwLFj1j6/XBz/G24ZgYbOkRm2tg==
X-Received: by 2002:a17:906:2921:: with SMTP id v1mr23259149ejd.236.1572865779049;
        Mon, 04 Nov 2019 03:09:39 -0800 (PST)
Received: from fiftytwodotfive ([2001:1438:4010:2558:9033:8018:ecb0:7d65])
        by smtp.gmail.com with ESMTPSA id d15sm933211edx.78.2019.11.04.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 03:09:38 -0800 (PST)
Message-ID: <148a5e07db186eb91d5a19bbd7a34bb8df193afd.camel@cloud.ionos.com>
Subject: Re: [PATCH rdma-core 1/5] pyverbs: New CMID class
From:   Benjamin Drung <benjamin.drung@cloud.ionos.com>
To:     Noa Osherovich <noaos@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Date:   Mon, 04 Nov 2019 12:09:59 +0100
In-Reply-To: <20191104103710.11196-2-noaos@mellanox.com>
References: <20191104103710.11196-1-noaos@mellanox.com>
         <20191104103710.11196-2-noaos@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am Montag, den 04.11.2019, 10:37 +0000 schrieb Noa Osherovich:
> diff --git a/pyverbs/cm_enums.pyx b/pyverbs/cm_enums.pyx
> new file mode 120000
> index 000000000000..bdab2b585a1d
> --- /dev/null
> +++ b/pyverbs/cm_enums.pyx
> @@ -0,0 +1 @@
> +librdmacm_enums.pxd
> \ No newline at end of file
> diff --git a/pyverbs/cmid.pxd b/pyverbs/cmid.pxd
> new file mode 100755
> index 000000000000..56bc755daf42
> --- /dev/null
> +++ b/pyverbs/cmid.pxd
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
> +# Copyright (c) 2018, Mellanox Technologies. All rights reserved.
> See COPYING file
> +
> +#cython: language_level=3
> +
> +from pyverbs.base cimport PyverbsObject, PyverbsCM
> +from libc.string cimport memcpy, memset
> +from libc.stdlib cimport free, malloc
> +cimport pyverbs.librdmacm as cm
> +
> +
> +cdef class CMID(PyverbsCM):
> +    cdef cm.rdma_cm_id *id
> +    cdef object ctx
> +    cdef object pd
> +    cpdef close(self)
> +
> +
> +cdef class AddrInfo(PyverbsObject):
> +    cdef cm.rdma_addrinfo *addr_info
> +    cpdef close(self)
> +
> +
> +cdef class ConnParam(PyverbsObject):
> +    cdef cm.rdma_conn_param conn_param
> \ No newline at end of file

Please add newlines to the end of these files.

-- 
Benjamin Drung

Debian & Ubuntu Developer
Platform Engineering Compute (Enterprise Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
E-mail: benjamin.drung@cloud.ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498
Vorstand: Dr. Christian Böing, Hüseyin Dogan, Hans-Henning Kettler,
Matthias Steinberg, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke
Member of United Internet

