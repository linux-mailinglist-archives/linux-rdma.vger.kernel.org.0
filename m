Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A71F8A05
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2020 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFNSSn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jun 2020 14:18:43 -0400
Received: from mout.web.de ([212.227.17.11]:53957 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbgFNSSm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Jun 2020 14:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592158709;
        bh=GjzZSg97gLmVC/vC7cvQK/ON+SukqvS1B4g5gyTuXzQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=VvsFfJT1NqmDdtAd/T5rW19HOeJki1EeGeftNLa4mlyzX/2r80IRalypBoJgoVV6x
         FSk6p8OV+rt1fL5K/0D4fzUGQEiliZITmcg81lYo7Z0eTtXtfvhEHvuCIhbM70txOu
         T5FSEStnj0Z2uulXoD5+oLWqNK8sgHR9p6uhe38Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.103.145]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNnw-1j73a90WTg-00mdVi; Sun, 14
 Jun 2020 20:18:29 +0200
Subject: Re: [PATCH] RDMA/rvt: Improve exception handling in rvt_create_qp()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Aditya Pakki <pakki001@umn.edu>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kangjie Lu <kjlu@umn.edu>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Qiushi Wu <wu000273@umn.edu>
References: <5d99dfe5-67ed-00d2-c2da-77058fb770c6@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <308f471c-8294-157f-3e3d-4a7f6473381e@web.de>
Date:   Sun, 14 Jun 2020 20:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5d99dfe5-67ed-00d2-c2da-77058fb770c6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aPcF2srBc3PEDSMgfGVR5kwzahjOzDbjeXJzrI6jVBNbVWNN9Jt
 om7cQQHZqvLw7tr6vhVzUJGm5eVj07FBPQ9qeQf+Cwch6VIeoJnuVgmBbGHeTcS5iXXtAjk
 hUurIVo4BGrnkIceebOy/wScvyYGyQAan1HlINTCTb756ksfjIPQ40lWPoOJO3m/Myc82/1
 WCqAtfO0HfNq/maMX15OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y1cvzFeKGPE=:L4gnnwqTXX3dzFGvkUkefu
 d6DLSHTJShkb9wU6KNp7D0HzgO2wCs66zGA+6/dnOcfF+S8rbr9p9FrP2D48OWdaXIRWqkWG6
 V15ZrrZ2Gff21llnfL2p4PDU/yKJoM23zeCc9w16cFbYv9nu8TxdfMrW0kHQCxoBEAh3b6qQi
 vt/c8y9ZtFzZ0Ns9BrHUL1Bf5umdZ8ZJUJbp+uMH1RAJe7CMI8XZPMtA/CdhgmZAFmwUSdEw3
 Mc4SLi0hLtLLnlbpOaHCVqelppGt8acpYuLzcSfm85wNtwJuSFc5/Q9KCsXbK+HBN5dvFOALM
 9L7oZGEGkGbepHDa0AzU7HVYs9JgSxew++X/pm68w8hNpgE5v8sLA2zez1smzxSK5hn8ej4tg
 Lj3JeNL3cjUC69kCyuFaKolwl8iqwfXNkQSnuKBhSvefhBEx3lINaTLMuBnoNkn4opfY7TbxI
 XHTC5W0wYWFKXKIHLGJAr+TbXQtu7/mZLsLihKqGIcd7Hj0gUSJ3jQg6o4pPa9xp3ZSd1oOsD
 L1s83u/vZXYR2BbnATSiC4RW71zGkvlhI4e0cxdmnKb5Z9SkbX8hWeUM6Uf6aeOG5wegTdBha
 4utf17l4nWasb/HLfPAiylv04/7B1EVQ+8Sss/wnJtsu6qxMb7r8QlR5Z1gr7QTjIgP/GxOw2
 sGwT3PhW2v/nFjyRXGSmDoE4gPp6UN261B1TJAAiqnuMyO1XmPIetVPSYzNddYlGBK7Ng4zFv
 RB00o1jEkkUuu2xjkYOCiokistJEl60m876ANGWiVWagE0hHZus85637aMXFKUWWPKsDDbV0o
 XwGnpdhXEKm2MtCHnoDMXUZzy3+v1Vvw+eeuY2yQ6oQib6dnsOhVyI/PiuzNyem7E4c2rsvlq
 g/rQ6CK4vE+L4kcOaaCQ6XvW4rcQjcq9ty7fyc2vF6oeZzSedhWyu+1JzankhZpnd9bTGY2Sq
 2eEfSI/OuGHo/Cw4+hykVMglznDkmwwn0exPUlG69/ce7YF5cUYtFxFg7uDOMaQWPpxEkBdpT
 k37rGztyISW8FqehLdOac7dqXMIf4P4OYwcfBab78+fCnxmnSy5kqVvloZ/lfaa64736rB+2m
 Zdx28vl6ZFDaf5XkvE5dKJGI4sMdKfw3yWeIwTwWW+E8UL4QAbg048QFK7bflb32Wzkr9EwIN
 tlc0JgxO2Ifko2unETySfxW+VB040Y1uLEL53N74reltwnilb54MOiHdJ6cYrzrqk9fcZ+ayD
 2vjirUZInm4TpiK7u
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> =E2=80=A6
>> +++ b/drivers/infiniband/sw/rdmavt/qp.c
>> @@ -1203,6 +1203,7 @@  struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>>  			qp->s_flags =3D RVT_S_SIGNAL_REQ_WR;
>>  		err =3D alloc_ud_wq_attr(qp, rdi->dparms.node);
>>  		if (err) {
>> +			rvt_free_rq(&qp->r_rq);
>>  			ret =3D (ERR_PTR(err));
>>  			goto bail_driver_priv;
>>  		}
>
> How do you think about the following code variant with the addition
> of a jump target?
>
>  		err =3D alloc_ud_wq_attr(qp, rdi->dparms.node);
>  		if (err) {
>  			ret =3D (ERR_PTR(err));
> -			goto bail_driver_priv;
> +			goto bail_free_rq;
>  		}
>
> =E2=80=A6
>
>  bail_rq_wq:
> -	rvt_free_rq(&qp->r_rq);
>  	free_ud_wq_attr(qp);
> +
> +bail_free_rq:
> +	rvt_free_rq(&qp->r_rq);
>
>  bail_driver_priv:

The improvement of affected implementation details is continued with
another update suggestion.

RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq
https://lore.kernel.org/linux-rdma/20200614041148.131983-1-pakki001@umn.ed=
u/
https://lore.kernel.org/patchwork/patch/1255709/

Regards,
Markus
