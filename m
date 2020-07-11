Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D173821C380
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2020 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgGKKFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jul 2020 06:05:12 -0400
Received: from mout.web.de ([217.72.192.78]:48899 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgGKKFK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jul 2020 06:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594461893;
        bh=oAB672Lav14N4Vgw/LehsEYrm2ioXvtEboTuKTDs2tM=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=czzoSMMDGlSq5mdNWRWJ+/w0DyqDsEFZ2a3Q+mQycMtXdrnUgSMgB3KgyQ90jJN8y
         7+YlXeC+ajeBk5zngfucMcy3Qvw1t3QXdXDl5jUU2SouA5Civ4i9IM7s0zN3ITbYRm
         +ytQCedJRHYiXykzDdniZL0xGDiuverJHFoApNkY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.101.136]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLt5-1kv84I2p0h-011lbN; Sat, 11
 Jul 2020 12:04:53 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>
Subject: Re: [PATCH] RDMA/usnic: switch from 'pci_' to 'dma_' API
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Message-ID: <e0f440ce-7f0d-efbe-5419-763a97aad68a@web.de>
Date:   Sat, 11 Jul 2020 12:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sVp10qkhMXnDk+mYX5gXAe36om9+FDML3yARHw6Fl0eLZuxy0+g
 iLtSIj1Gc7mByedKQRX/3WAlfQa5oLjlLLveKXc4XnHvlufY7SYxxBDmlMu1THdrk02zBqw
 qgAEZypM2EUiHb5fBXE24Nvb3L6HPhpOlALssEtLUopUnjSbCxYsEMTPH+SrgApNNOLxeWn
 DWgsQubyqzJEPeHmRyNKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+p6JbBxeNf0=:F/NqvLvAov8/uUtCXjWJ6h
 cNxG0HWUPYaf+Asdb+wrbWX7ZishXWX0lE1ml7JwqwGyeRyzZrlqH9TJmKdBsUtfKNe1mlkwR
 y49pNr9Jupz4/cTYaVdYzN4XZJh3Zou2eOdqSjyyGwC86ftvvnAHAxadhKzGq0vYqW5VAQeQ3
 0VNVr9TSfInznz5G2NKWjuws5MxRP7DXxU+ZUqxWQghgoeOCIgoR8HdxopdhEks139UiL6wOe
 S+UyVegc3KZGlWlPr2bPfVIZefBo3p5YdnusS+YewlxXCguLMdktE15G4Q9qnAT5CmlCI4XcJ
 nMCBbOCMnhMQSsSKjNV0Cr2X2wuSoePi55+6sJ1b5lCkGDKgpUey2SinoagEmaKjVhWmnaK5s
 GhrnlIrQKwYco2qHTOwoHe3D5YrOUKVWRQPgw3KX0U6VJRtsjHPwBfYcnWw+W9w7Yg4CXK7ak
 jjdItP6Yw/YIEwQqhvsxSBV1lF5WUERaGXGTNGYjfin1T/6et0EVRctzOL7BFpqOXOf4nHm0b
 iT3J0Eblmf79LVdDTqIksP6xaRJTsCmoQcgcXNuyBAd03lW7N7d/IM2sdhMiTSj+Kwrxxp1/6
 +Y0Fqx42v/GRtq7rK4ap6bqttAtFrHYQdjiW/BSD27syUq5i2L1ylT6GWrN/1krJqFgBnbiLp
 5PEj3iLeUhRH6LHQMhJJrou3aQMukOgVL0kegdIUS44zzwzc2tLqTLNF1slBL2PJdxJDI4AXL
 DSm7uiMNooS6hiUdY7K2Jeben32q9+3NAFkz6AmlEbwsK+BxriX4+48vlTRMTKgdVXjGVhaiB
 YmW+D+yIcvFQnE9LQDZrJwwKIuZwvaMw7KbRpZSAUbo2i1vmNl/7GR8vgUMeraBhkm74LYvYV
 9/MHGWP0VBW5BhVG1Zuaxj4qVKig358wgkO2wHKrRDQQ1sZ3hfC/40KxIPav7lKWtupozkfqB
 rrsMtfTwN9kq3YEcKTYmZgXMm5w+zlNMtgIRjFat9aeWSwv3SR/RZxnyU7IBRRn5ddZEyGLym
 wk/UCsD9pb1DXQsRopLM9yEOt0NNXDJ46j/Y5jipb0pBGgg0aLCodRclHUjeJRQKjB7k9vqRC
 jWQUHLyTJrGN2UDY3A02ZxszLyLdfAlj8/113wSHxVeTQQQ7Bky49X2rEay4JQnahB0cgz7v/
 9ZcP6FKor9loWKy7d9BH19pFT7FE8LS0Q8eWM4t9u14Z9ZzCRw2C2iSzeqZ4IVvdAMDBZ4j+a
 /39PJkZr60y/aDhVf/dUTvrUOAgk//rDjRp3MDA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script bellow.

* I suggest to avoid a typo in a word at the sentence end.

* The script for the semantic patch language could be a bit nicer
  by the application of disjunctions instead of separate SmPL rules.
  Would you become interested in any further adjustments?


=E2=80=A6
>@@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

I find the last function parameter questionable.
An other flag was specified in a corresponding diff hunk.

Regards,
Markus
