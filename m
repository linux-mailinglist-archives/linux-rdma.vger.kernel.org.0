Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E751D55EC
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgEOQ0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 12:26:04 -0400
Received: from mout.web.de ([212.227.17.11]:50275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgEOQ0D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 May 2020 12:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589559952;
        bh=MJy3u2eAO0hkXrveSlr4+ROSkr3dNK2kMlqQXTE1l8k=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=eYgLn2+CJ7P0SfCYXVKHagzAx8y7x4KnHQmhNJyyOTf9fsryBh6/88Z57ooF6zfyF
         0e/punGW+WkczgPP303epZVlH0Rt+D5LPXW8r+6oBefMvgOUyGeZasylYCBmpok24y
         +IrGNyqFPcOfbMGY3w+9LjZQVwjVh38ip1hQ0sUw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.164.161]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lnj7L-1isLiZ0vBH-00hvY0; Fri, 15
 May 2020 18:25:52 +0200
To:     Divya Indi <divya.indi@oracle.com>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] IB/sa: Fix use-after-free in ib_nl_send_msg()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b4b66f61-d49e-fd87-87a5-7f5bfff6fd7f@web.de>
Date:   Fri, 15 May 2020 18:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LcCBZhor9WpnLF02wGAaBo/E2Exu1Z8aZzCiPdWs16gBEcjAZTy
 LDgvYzZNaLFmf09nKtnMT/Tc59F4w0lXyL2mEJfhM6iW82tFNFLUEb/2klA3JRq0b9H9Vxp
 TyONplvlY2qBITvI1VLOcSLanmfLQgagBhLHbAvYlI5gIHOGJQuaOlH8ZWHpfNlLGYFIyF2
 VjyAlAvSGcBu63CBI947A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQs/J0HN8js=:dfdpH6NfeTiGcDNq6YjYN1
 7kaBxcaCfeYAydjrnwvfztSlV7nLywA2Jh6LcTiYKK7+6sS0YgvBfsUeGo5//Icanqlysj18S
 rEHJwimwl3hiM3jXNvPmhjjYi7+5zwqWibBtiQtEz28A7VLIga8njuubf8N1zd+0EVsvWrEux
 22bwyc2CiVpluE2FpKQ8K4mD/VogK8vTcDCiTTbskFNg+3Fci39dsokNKyfl7KHTc8Nigf/jf
 za8WmjaSZxfzlagUsF+058gx+4TofrdPS76Vng8yOSCTrOA7l5mC19hJ7dLFhwmFN0pa9DN3M
 Ok/nC+bC2k34irKMpDSnoTzuoYilofikFyKEDrWE4vczoMM1DJ+jqFENlPHMo+WhaExOu12dw
 lJ4I9Mtessh3QAu4dgsx995KPE7uEwPx6+OXXrRH5sHRywvFXgPydQYEMunLizb1tgBNuLm9v
 /7/MOxA3xH5+j6Eg/Q8pqxW2PjD+bs6BGjMPsCf3LoYIpnRkNJDwjYmPCOLh0zp5/t6LNv2vb
 n60YxzafS58PlJQZYuzEZQ92+JYttkRb2bnqKy4NkLqMJuhcEy+ljxXX10cxx2sLOv97r6N4v
 l336fvsxEjXJFKO2ZuZ3/jqDdWPhK1emniz5OH4Rwvv5Be1o7qc7VONzOUE2g69SB0RjqRSrD
 q0v4XimuoF4otUOIiwjjLScpIdrTsaMXB+qRPOz3fVNSt7VA+0mMBikX5A2LinayQCtbIkJBT
 wIvppIR06CRD8ZbcosH0/N9nqkqfyhsTMHGmfar/TUGNL8V5naJRSjel76PMhoXnU74KU7AC9
 DAvPSK79Jd0U1nlVswxRYLtFk98jPZsVpmpLx15fNr7m8IcNsgJqQ213xWN1GA+siVA0Ok/jZ
 FOTCXFMN38xyt3I67cAbMmC2cTS9Hla9M57feMboFZwCa5m/5i6lhTNMxBNCkB+0+1a0843PA
 vYppGv5O1T6YQ12pDhsTsven57oSKFiuSvRBjiYRqyyubnN7QaIbtd6BCICc/pVzGDQVGLiIB
 F9QCBaaqLz2MdOskZTx9lv9kyl436Jxyfcv6hotJ2MzTniGW0OZukQhZwrhbY+913WmE+mJVC
 vwyoBjNhFufOpuwdXV7h74+Cy0TVlaH6XGHIt4HMt9CmcBzTABHdEZMkX1+99OajXI030lhtz
 TzygSTuaGPlMv8DZXIf5WMaTwgRuHxLgHfZQOEmUtVP94OHggc88yZgQv+rCYvj4M7MZgy59C
 pIi16y9NcxTAjbd2f
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> This patch fixes commit -
> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list b=
efore sending")'
>
> Above commit adds the query to the request list before ib_nl_snd_msg.

I suggest to improve also this change description.

  The query to the request list was added before ib_nl_snd_msg()
  by the commit 3ebd2fd0d011 ("=E2=80=A6").


> This flag Indicates =E2=80=A6

=E2=80=A6 indicates =E2=80=A6


> To handle the case where a response is received before we could set this
> flag, the response handler waits for the flag to be
> set before proceeding with the query.

Please reconsider the word wrapping.

  To handle the case where a response is received before we could set
  this flag, the response handler waits for the flag to be set
  before proceeding with the query.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
