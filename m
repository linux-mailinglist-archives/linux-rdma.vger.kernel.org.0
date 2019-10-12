Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06AD5118
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2019 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfJLQnI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Oct 2019 12:43:08 -0400
Received: from mout.web.de ([212.227.15.14]:49195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfJLQlI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 12 Oct 2019 12:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570898452;
        bh=obvEHiuTwY7nslrmcbLeBF7twJB1P7Dm6ZNUvsNfLRM=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=mQ0cm3g9VKIA93OtN3pW+QrLrkOE98PJH56qem0yYXVmA52YIByzhrHERKvuYOKjK
         sHV659MqUm1Tj7yE9DySF93bo3eVND0kYk0JoFGTbPh5E/OQbuy5lsK4wYMLKkkFx4
         VutAAzQkHtDzUFl1u8KQZFhrQ1vzER0n3FrvKkfY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.250]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfHhK-1ih4Oc1O02-00Ooxx; Sat, 12
 Oct 2019 18:40:52 +0200
To:     linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: IB/hfi1: Checking a kmemdup() call in get_platform_config()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <f566cf8a-96df-f145-296f-8f6d72d8fbad@web.de>
Date:   Sat, 12 Oct 2019 18:40:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SwcYdJegrILwnr+2Wfh99SPVzHk60Y7yLV579wW92OTzGmBbKHD
 2ljlk9n1O+EEGTDtTfGvmoFRkNQI19QIeWDuUbQIR5QO7dyviVwDfe8i1q3FpTLT2L9unbT
 IsV5qxDESXSZCZTtEadkqj9DBLz7lcI8qPShouhysDe05hSGiFMZQwR91Tqc3jPlVu9biko
 exjqgbGGz9OVReWS7SU4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dLD4dGWOOug=:B/NZkCexY/ybxYL1PKgHaT
 VjTflKtup49RE/o8AgJLUy3W8vdTcocZXMdqrC/eDl2j/AoqFjn1lz1M38qplt8bAuLNN65nS
 A1/8uYmF1QtE7nuZ/LtaHqCBJJFZ47zATJ4aHa52xNKPgJfFrUQM9z0wgrehFgCeAVDTC88BR
 iVCVV/XyBXRF81M68gKzbEyWEjHzvcHT0BNMLeYP83QBxVMcxp2X0XYZrMnzJtAoA3m7MgFI7
 kncmoWKPnpnrLAnFY2rpiSG9haIUXcNpA6lPYizWBDBzCwALdBgpK2iOipMROLVMinZcgjc4u
 AStf7EZasKAw6XOyFLetQTLJ34ndBYXbz2a8FKh5ZPK8u2+Mi5qj/jUOhfGwQ3sWqv+RpYWzB
 S9WuLoyGC+0L53OXVto9SF8v40mdewY2H7T3kWanKmmveJ3XKRkJMLh8U4iiig39G2U5YfVpX
 BMdwX1YFXtUDZVpjYDqWqn3BgNwfc92pExjnJwNlRMuIZ/2/acIWBJWFx3sb+W9ouR7QjGVNw
 QKQFCgXX0jAIiM3csmfFrNZb08mQ2EeWWaLep0A5xGhNaDsoEslFJKXMxcuUAbn8V36ur5bi8
 QDdzlizRTOXFRTdifdqY4OmPXdhzJLovCcm3hl4966RLdlqSo87JpPzYrI7Qc5TxNWuhizQHN
 l3dXMTW/fnoRrzCKBiTxkx5B0cf7QynmvrO2Yzt6xFtsSlLtIKUbobme+jBZQzEyh3SOA9c9/
 mcDxX2Tw5w9dv8JGpAeuJeC6JUYlVejfgtNdI7kVbOkt5hxUiJK18SnS+0q2b+SgXzZ/RlC6x
 8s6nk7UkZjgAHt3Tvdx4btG2No+qWPwAw7AvRcS/PH9Tg6QY3wuSSC8Sye/7mh6RC6EtmvNPI
 4Fhm+jzz/luAx3P7Yk1okaRHt/4fgV6NmV+7CKevlaAGkW+hE9S3pCQQOSGFPgO98hQ3jYYcN
 O+0tZ+QahEJGkxoe5AEu1b6646zoLHdTU27CYmkoyQurZROnN7QMQ/4Ptg0OElItoEoHqbu7t
 tqdLyT1dtThtFUWQ8CB89+J/38/JWYCttLsWiI7n/8qZTQAfg4nWhWa7L+CT3FdBqoY2NclSR
 EUpQfPx37IGL7uFtHyUUIWnuGgu/mjugTFrQRJPxvLgToAln4WWpAnMVU7go5cflYycL18NXT
 clrHA6JHJ7OKKa123VvbNxxAhmXBvkVoJByZsmJpgoXvJZUBjk3rGrrDiFdcUzJa4DI52MHCv
 OEg2TLEBxozjT6gHCwqiYmEsrC6TY6g32MGx3p6xNaA8/oiBgG+XiWaeVj6U=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I tried another script for the semantic patch language out.
This source code analysis approach points out that the implementation
of the function =E2=80=9Cget_platform_config=E2=80=9D contains still an un=
checked call
of the function =E2=80=9Ckmemdup=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/infiniband/hw/hfi1/platform.c?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e996=
04ee30a#n187
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/infiniband/hw/hfi=
1/platform.c#L187

How do you think about to improve it?

Regards,
Markus
