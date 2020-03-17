Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4181888FD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 16:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCQPTI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 11:19:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43148 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCQPTI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 11:19:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id l13so17695791qtv.10
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BfzrF8b/EZdcIf7G+sSC1rUzeCq62k9NwB0quV5cf20=;
        b=Ia5J0N6jv9suXu2ShNnZ1etHlWkhm2x1YzrzD770kh/pZPf3iyQOefOENVRilPQUSo
         OlyIIuMi5zt18YcHqQgo48szEciCsL0wRyhigq72Gfv9v0c+zjPdkOHlNbhaa+aFqZry
         02XmtZVk9k5WrwSmom+f5INjfeUjLZZ14NiBa3GnVjMFji57GRSrg/hmx9bSFUysg8DK
         c6Bdl/0ZrigFrE0iuSAjIZ0oYjPVYudaMWjXjIv913cEuhxGk/FeNQ6GgoQBS2d550hW
         cl7VxM9XDFFzA6eQdDdP0C4MqWtFmdJRdQLdSnQAXUTag9V1Lcc1FpBKdikCSzlmav1I
         Bt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BfzrF8b/EZdcIf7G+sSC1rUzeCq62k9NwB0quV5cf20=;
        b=hghD258CSuSPmoOK+IIl77SbqHuwc2ll9S1nX2GEk1R0r+xkGUVKBN+q70cNgePNRA
         SjNYbe4qe+wIfIwjr6XIIQJhzIW7RzHPGhpt37JDWrSkwJehsl3NCHxo33PKZzoEiaC6
         ItUc0LYN632Xk1Z6D0JlDcPXHsmhZNyqruOsWua6Opv70p88lz3ZyLMI1chkaF46d3or
         +VPXU4Bv8HOz9LqMuwL9XIqmB0DTscRpCmyJTztnfW6Yf1TNY+n5xDC1dl7FGl2xJWmY
         fUGaNy+Vb0La4YOgJRsM51FA3742U7l1j9UBljMr4qx0oF6pz64thCzJtG7zrdBQFpQG
         d+cA==
X-Gm-Message-State: ANhLgQ2gkPVu1l0t3AtIZ5MdXUTykNgR35XpbAbUmC+lsvUEGBdAd2gv
        rcCh42U4ugAkKEJZaBVg+go=
X-Google-Smtp-Source: ADFU+vtL/mvFInxC3k5sdjwKUeJqbhTW+2Vb5R6HTklqOejkfyHSGWpjkx7EIZ/vIn1EkWfIy/qzwg==
X-Received: by 2002:aed:34e6:: with SMTP id x93mr5892427qtd.194.1584458346844;
        Tue, 17 Mar 2020 08:19:06 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 128sm2080034qki.103.2020.03.17.08.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:19:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20200317134030.152833-5-maxg@mellanox.com>
Date:   Tue, 17 Mar 2020 11:19:03 -0400
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, leonro@mellanox.com,
        jgg@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, Oren Duer <oren@mellanox.com>,
        vladimirk@mellanox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Max-

> On Mar 17, 2020, at 9:40 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>=20
> In some cases, e.g. when using ib_alloc_cq_any, one would like to know
> the completion vector that eventually assigned to the CQ. Cache this
> value during CQ creation.

I'm confused by the mention of the ib_alloc_cq_any() API here.

Is your design somehow dependent on the way the current =
ib_alloc_cq_any()
selects comp_vectors? The contract for _any() is that it is an API for
callers that simply do not care about what comp_vector is chosen. =
There's
no guarantee that the _any() comp_vector allocator will continue to use
round-robin in the future, for instance.

If you want to guarantee that there is an SRQ for each comp_vector and a
comp_vector for each SRQ, stick with a CQ allocation API that enables
explicit selection of the comp_vector value, and cache that value in the
caller, not in the core data structures.


> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
> drivers/infiniband/core/cq.c | 1 +
> include/rdma/ib_verbs.h      | 1 +
> 2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/cq.c =
b/drivers/infiniband/core/cq.c
> index 4f25b24..a7cbf52 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device =
*dev, void *private,
> 	cq->device =3D dev;
> 	cq->cq_context =3D private;
> 	cq->poll_ctx =3D poll_ctx;
> +	cq->comp_vector =3D comp_vector;
> 	atomic_set(&cq->usecnt, 0);
>=20
> 	cq->wc =3D kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), =
GFP_KERNEL);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index fc8207d..0d61772 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1558,6 +1558,7 @@ struct ib_cq {
> 	struct ib_device       *device;
> 	struct ib_ucq_object   *uobject;
> 	ib_comp_handler   	comp_handler;
> +	u32			comp_vector;
> 	void                  (*event_handler)(struct ib_event *, void =
*);
> 	void                   *cq_context;
> 	int               	cqe;
> --=20
> 1.8.3.1
>=20

--
Chuck Lever
chucklever@gmail.com



