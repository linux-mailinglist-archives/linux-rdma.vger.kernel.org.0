Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F851B5BBD
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDWMst (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 08:48:49 -0400
Received: from mout.web.de ([212.227.15.14]:50377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgDWMst (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 08:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587646121;
        bh=fOzWAq+BxxNO4wDiG0WjGJ6oBJwsabV+dzVHOS/NSfU=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=XZWWFvzHQqqtDFVXK6ep4zzv8pO8HZAlsRKRxRigHw8/dr2D+l5uBydf5nk4i8Wg8
         LngV4wKkPbHks2hy9KWSScvRJ0ofHBQaN+EFXYSfNU+bFOr6pxVwZdXOSaVXVaTCjt
         k6SHi36gyXZKR+r4jVQljWMvLc6/T5eSxJefGGeE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.235]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Md4ZG-1jjoeh0hda-00IC7j; Thu, 23
 Apr 2020 14:48:41 +0200
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: return proper error code
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <46c46e8e-c124-929a-6760-13cade450f30@web.de>
Date:   Thu, 23 Apr 2020 14:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIBEuSu1uYasvz4okGSlSQRru78bnEZewyg/oOvnj16PVgrUJ7c
 8M2gMUmsqpnUVpAikGUAwB3D+eufWppR0ooBFvPNNX2Thrjs0kmPqxlCDrD7IaVtRDsvHFD
 k4hCPh4k6VIe+uXpC3QZsN9QmBK3WarvJcRbe/C9Sq0mWEnpJEhx3OCu17xg5qzsQnXxBkK
 I9/DWFSvR01VJCGZM6VSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pjGfSC6bFks=:TP6sNth8R0NFreUhq7s/CY
 GOH9KFS5c95Ib6jb0JymmgIENAeXHauEuTXdqzKxpVV4jh6CyVA9fmmvnQUflzae7aMnpJ1/f
 rUJDe8ypD9o0LMq1PqTc51Si4G7AppcIicC+fUS5KLi6UsXjWriql/zoNnRyBouoHJJDkWdSs
 ZHaKgD6oeyJBQrEq6aVQNDcm2iqpfLKm85ytO52neIl4gMEvWIsox+NcYyUue3lF4aO+irGn1
 JcZq8ATJ3I8T4XL2b3g5X6LWqRWFeGhetxXkWBuH33AsR2s6+COALrg0EOAR0gsehfw7hLBBQ
 x52aeGUGfxGZYHZmfUffJbiy1fRwESBcx4h520fHTX81x+XnaAM5Ex1jIf+mpUcVLe9siLPPz
 WmqiHcfGPrHWY8fN0Dt2PJbr17rfV4qYEcgKP5d4ry3zGv6AWYmsyjF3u9HjaZlvi/g0/VlN6
 xBcZrOZuVA2Cb9WjftfrVQ2+16v6jAXNNIB+WMh9WmHWFTciSoHFha4mmdcg3IbMNyfmke6aX
 jKAiVNfTDSXUIOhL5bsqXVTiFsK5/MxAMzgx2srMBoiXnmksOVCQgXXXSbYYmQpIGFWEPZkqR
 b9E5VQItSJhBeMv6nEPxLuXIanHzuqYLVacmoJUDytkk9Xfj4Z7FCQ6g848zdIq+3hMwZsbMG
 U8/2bhdI1UTuOlII7ktmY07m05vVk3O6bC4euTUaWYPGOcjoHoKO9WqJjFj6awGWDOwbgbVFs
 EkJh0iSb8V2iaOSFNhr4H6ddR9clpMYjXJKf3JmFskUutKqG49mAjOG6l9sc+QUFwYe3pNutE
 PKiEAmwN6U53ISH2VAoySLAT2c6OvInfkRhFLLXPTcG3iZazqZb0B0rQL1GCkryAoI2KTtuwe
 DeoXNGnjktUWsDvMVvC4tr75iYksJZip8nsmZCn08NyTMy3L94+TYso/J6CMnRvn1/q88Dbj/
 wGQOoXN/O5Ot/N1P0Vsrtgo2rm56zn/1pkUsv86jGlkeAcUVq8mC7Bf6xwHCZ3B+WNrOLm4Yk
 IcNUcSTdqPD5930KU6ide1UcdQAkCtZYLwM1nnzrzy4y1ne12eExajQPKnbVqB1hRrMF0Ht9T
 0dDnpRTIMnCkT4FVgwwoF0rQ86zeijiW9qX+OcLMAU/V6xsT13aP6ktkzcYiqUnFAEbLZLjw0
 5MCCJlRQGRJ220Nw+TJjrZpC5dzTXLzXmG/75f4h9GlLgAnrK4JCA9O3QR6pAR+7Vwi6zc2v5
 rdzpUZwa+z9slFemf
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> The function rvt_create_mmap_info() can return either NULL or an error
> in ERR_PTR(). Check properly for both the error type and return the
> error code accordingly.

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of a=
djustments
for the exception handling?

Regards,
Markus
