Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1022D6CC
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jul 2020 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYKhi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jul 2020 06:37:38 -0400
Received: from mout.web.de ([212.227.15.4]:37545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgGYKhi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jul 2020 06:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595673444;
        bh=8BMDX0FAWi5z2eYjhdMKeiO1bxSYdDfE+5y4dWfsENc=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Hhyjye5xwfPohA6Ezv6nz9YxDZqsKfgsRhMDN+4Bv6uM2fWG+zqKXMAdFvD7deIgk
         jwdBJLCwZDsJWgSYb8bs6MNuo6iXsdbKRkl+6x00MuzZtt2JXrk0w9a5fAXFL/A0e1
         zCZy5Y1Q1IU29b6DozKresrhxHRCGjdpn13TP72k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.94.55]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1kY4PN3djS-00b4pQ; Sat, 25
 Jul 2020 12:37:23 +0200
To:     Li Heng <liheng40@huawei.com>, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] RDMA/core: Fix return error value to negative in
 _ib_modify_qp()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dea0923d-669e-b5c6-9192-4c4034290b53@web.de>
Date:   Sat, 25 Jul 2020 12:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:f577eOn9QmzY+K8qjWlqLBh6N4CbfPRhdTaIe0YMwfMW4BJG//V
 /eJlw4dcuiq8qZpxpTsz3oiNoKpKIdaYpbexaOgoKIxaI/sFVUX3M0qS5teUtAjlwh5BTzs
 mpVgvoQnSC7iNKNn2p1JTMCVxqfEs4as53wM4y+Z+rCZRT6NLoZREClb06rOki0NeKC7DA8
 gg5a5dQfMP2Qf0Uxavi7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TE6imnC8r9Q=:oO30kOpF8jt5OvIPiH3bwI
 qsn9b+VYyH/Cb4rPtpGtXWomithL8+mEybdDzOET1yfaPqIHZmtvFYa0Nv/mWTuifgXKtiqNC
 pWI576yY8KT2069VqZ9EKj1We2FfPRh0rd5ID7paeFsybZn0yxxvvn6mYFz2SYYTD33KoKraU
 zkQgU3pTR+Xr349A3bFI46PavZo1KPt6NbXWW7WJdbe/axPYKV648nFwbZFglrKBT2fhB4w6k
 XQIr6oqPtIdgG1mze5bVyvD7HC2nVl9jQzVu2yIJWJt8DYS2PwGEphYBGxf5h38t39HEuFzpe
 HOTyceGLTp9UUHc/L8S6wkBbicpwayPpSkwDkEh7+zSAr1yIeFFuJ7aQyDLyRKsXtYDJzSSWd
 WlUmRzI0B89DDZoyb8ZMaHKyJTpFtJEyB+0NnrPbCphzNbKevPbX+4h9yFxsp5zDRpdjcEUL3
 tNic+oobJd8k1/fEm+l7ijjfj91AaEdYpNnk3Ahwg4y9ylFJ4uqvpsH5+VrfdGyigsvWhRsbl
 e0m0Kyk5a13UDLdrjoP56Oo5jY0q/ROEJ95E8GFu4ct+s0cvUJMM5rigw280JTIM2GheXzCsv
 oPBuasN3aRkaGd4vaTueINjdV2nAtf4R4UjUNCchJ/5OUiOpCxgYzyI1AXJX44VkMNxxBlI/7
 jWxrOgxsfpS3U9iO0hnc0ZMPHCZuxX7ug1KU1vS+sVpvsEbIcnQGbjshd7Ejm2GJxNaSkyrW9
 p0aP64MAkhcVWGWfcu1xYLMHc9e/Cau4aH2Z9ggaaU8bLXrFUtuGXOCUb0pgerhNUC3oS2f7P
 JAk2wkV79pHKPqv2sBwaoSSAi6zoyE7TkN+hyNZXsmC5s9zDaLN0d4URCMlrGin7mmdZ8jjbQ
 NwInqCBbqYpfVwkC5IWG4s3biPtEAyj0tXUK42w9lqG4UITxxcNjwwI73Zq2ldqazXVasilNi
 5+OBNnSPZX3sgiM0WDTOuD8QjsGGJeOuKSaJHzxQ5xMXNLcR7zouo7kbHtS0VHWVqcYSD3T5k
 /CbfDbC1aRW5zOnpsoTaMX8vE+1mwCKb7gOWBQwsO0vJs5tKlf1Cv3wN2+bJ5cYeHhlc+U4BV
 +mlmvnWx2L3bH2BJbMcLQfF5VZo5xCKXVi9wBd7m818IfaQ95UXmFRXO0mCC1/N6IXNoprUHj
 kSNkXwefu+THfGWgKPsyn4sjDCpehbZbfM1OfFz5hL4gFla5yKWhvsrOcDrdgnO2vrzTeahqh
 HZpHI85eUQLVw/iIienhpJYzRsG/RjBwKjAXt6A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please add a change description (according to a missing minus character).

Regards,
Markus
