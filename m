Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D105BE6C65
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 07:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfJ1GZX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 02:25:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37534 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfJ1GZX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 02:25:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id b20so6886545lfp.4
        for <linux-rdma@vger.kernel.org>; Sun, 27 Oct 2019 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U5RAXoFel6JiFEul8P59gVQ3AePT+MtgQnCRwa3TQX4=;
        b=Z1HmAxnfzdn9FoQZf+DyMDvMHJwLLsWJJUbPsWqENApbZymOmVxPjl1lOC4ePEDbeB
         U/S7eBT811AEPMeNkzgnKZ7Nlyr9+Thkld05BkFnmTBLG5VMJ+lMdrPfv96tMSDun4zD
         gduvO7L+Cozwk5XGL69xPZUzEZrkTh22aOqqX7gweGuFhisM9k/4NDzSIQf0Qxhj1QBz
         ibZfwCVSnyC5pAf/VxQ19qnGlIkLcjiBWCpW/usyvrtjaUFK2qCWpM2u3B76N8ABYRDC
         kiBhgF+AeBONyDxDgTxRYZfIUiHOEvvl0mq4LArLAT23Vp2jDCzAD49x09Z9fGC3pCkc
         J2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U5RAXoFel6JiFEul8P59gVQ3AePT+MtgQnCRwa3TQX4=;
        b=gpHx9nrOyAenkFGONzBym9vkZ3oKbvnZUxJjAp8gC4AMpbz/avT0aSDPZaTLbUKRBn
         u4GGPTxG6ZerVbWUXReodi9hY/+DOQk4lcOC/p3D3krV3ug2+iBiXoNeNCJElTtF4aru
         a5SgqUlLBG+lutWV4O7K1sul7JHqDJHUcFSXz2rmmL0fbTXxowDXwb1ZqvUIcJH+VN2X
         5+l04VXgBsxnbT8kC7xoHX7f8J637PDYO/S8bgmRmN/hzTkUmjdTk0L7jY19Jd5A5tue
         45MkyxcCG1bbIqHPZq+AWWHSDZREVKZ4FX0EMmwnyYNfLyHCMmT7yjlkkNJQSrfZ/LG5
         ZouA==
X-Gm-Message-State: APjAAAV1XSDxjWavukzfkafh9KrrrfpyqtDTi4pM31H+uQ4byKKTnLrX
        rwXjKoErGBJG7tjQHzRUszc=
X-Google-Smtp-Source: APXvYqw0j0UrHTIHan0AsvKi6C9ZtF4b4usbEQKMeS5HlaSqNkgZbkrJaFwaQtl9Hf/UEroMopycIQ==
X-Received: by 2002:a19:f107:: with SMTP id p7mr9997330lfh.91.1572243921372;
        Sun, 27 Oct 2019 23:25:21 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id u11sm1583705ljo.17.2019.10.27.23.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 23:25:20 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH hmm 08/15] xen/gntdev: Use select for
 DMA_SHARED_BUFFER
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-9-jgg@ziepe.ca>
 <6f60f558-20db-1749-044d-a46697258c39@suse.com>
 <91329d7d-9db5-057e-59d2-887254083da0@epam.com>
 <20191021191219.GJ6285@mellanox.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <3a53baa5-bc1d-e901-2792-8d51753391ff@gmail.com>
Date:   Mon, 28 Oct 2019 08:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021191219.GJ6285@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/19 10:12 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2019 at 06:35:15AM +0000, Oleksandr Andrushchenko wrote:
>> On 10/16/19 8:11 AM, Jürgen Groß wrote:
>>> On 15.10.19 20:12, Jason Gunthorpe wrote:
>>>> From: Jason Gunthorpe <jgg@mellanox.com>
>>>>
>>>> DMA_SHARED_BUFFER can not be enabled by the user (it represents a
>>>> library
>>>> set in the kernel). The kconfig convention is to use select for such
>>>> symbols so they are turned on implicitly when the user enables a kconfig
>>>> that needs them.
>>>>
>>>> Otherwise the XEN_GNTDEV_DMABUF kconfig is overly difficult to enable.
>>>>
>>>> Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
>>>> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>> Cc: xen-devel@lists.xenproject.org
>>>> Cc: Juergen Gross <jgross@suse.com>
>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>
>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Thanks Oleksandr and Juergen, can you also give me some advice on how
> to progress the more complex patch:
>
> https://patchwork.kernel.org/patch/11191369/
>
> Is this gntdev stuff still in-use? I struggled a bit to understand
> what it is doing, but I think I made a reasonable guess?
I think Jurgen and Boris could help here
> Jason
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

