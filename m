Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341861757F4
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 11:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCBKHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 05:07:48 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43546 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCBKHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 05:07:47 -0500
Received: by mail-il1-f194.google.com with SMTP id o18so4849471ilg.10
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 02:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEvmbBIx18PjlG+Fst7P3LZGNqRs/S/n3JaKm9gwzFs=;
        b=h5K926Fga7LyyArYo87OiT1vOtr93fYl1TTbrfmnU1lvRJcf80lWxzFrBU5FULGj2P
         TTMALctVEksH1GDYSx0hl+2NsyC68TkvIkrbUKDS/EKUocSv185fRIVb8f2zMN1vqOAf
         cqwq7YGLyhC118HHJPBTlZovmeuSeSLXsckSpnZxMItUJGyPcnxxTBfzpa4L9dFTga+1
         k6ONTOdxPC4Xb97cM2ID1q7Ac3DckJZcx+xUYpGEnDvsZJg9Lm30XSgd4cW6U0uay5ME
         Xkn2ukesTqNsHgVbj1BjsKM3cWvypJhdV8Esq+FUTC4ffWSytCrYy/ZbmrgA+DcTyo15
         yoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEvmbBIx18PjlG+Fst7P3LZGNqRs/S/n3JaKm9gwzFs=;
        b=lJi8AbaaJllyU+RHvOi5AwGibRPo7nz7VCNFQ+/MwZE57fSCSe84wmt6fnoeNzLqSf
         YNLsX0lCw9NJRFyabnKzT2jEZCUlkGoy5r5ItCRLLM0fcMqMilDx647O1OSLEPnIh1pn
         8lwQ3ORTYaF0l5Zw2NDTAUC+SgPSw1+Lobm8FHAKN7Nqv5rWkdV6fNqqvGkPxfALa6io
         u06RNwd44N7uKkm8q3T4DwCTIc2/x8o2Q+srFAvKpHfGWwEx4mvipOY3Yf/5QJx8gXBW
         MW64EQDCIwB54YMB8F38SSUhLIwqqgCN98Ae0DnDS6jwdzyKHCtHY2rtIFwRM4P4Cv4c
         ffRQ==
X-Gm-Message-State: APjAAAUGYrgN4fJBDUPD2iAnEsk08ntbu1FZdBR1jOvz2mhZbbpQlwq9
        usfl9d5gaZCP2t9USyFr8NPDW3ANnn2jCjLXf5dx
X-Google-Smtp-Source: APXvYqywElvcmmSxBEwDFPSsZbfOapZ6kkz+QSE41GtzDz5rb4WpCOKYr+hAvQK4RnF0UJ8Ea3J5NVVU2l1d6w+ih0w=
X-Received: by 2002:a92:9f4e:: with SMTP id u75mr15300769ili.116.1583143667325;
 Mon, 02 Mar 2020 02:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-20-jinpuwang@gmail.com>
 <c32d59b7-6cd5-2e9b-0faa-3dee29a26a91@acm.org>
In-Reply-To: <c32d59b7-6cd5-2e9b-0faa-3dee29a26a91@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 11:07:36 +0100
Message-ID: <CAHg0HuwVj-pokXwBxfeqMvLTHxdwB6q5fe3U_wps9uGYC9TrGg@mail.gmail.com>
Subject: Re: [PATCH v9 19/25] block/rnbd: server: private header with server
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 3:47 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +/* Structure which binds N devices and N sessions */
> > +struct rnbd_srv_sess_dev {
> > +     /* Entry inside rnbd_srv_dev struct */
> > +     struct list_head                dev_list;
> > +     /* Entry inside rnbd_srv_session struct */
> > +     struct list_head                sess_list;
> > +     struct rnbd_dev         *rnbd_dev;
> > +     struct rnbd_srv_session        *sess;
> > +     struct rnbd_srv_dev             *dev;
> > +     struct kobject                  kobj;
> > +     struct completion               *sysfs_release_compl;
> > +     u32                             device_id;
> > +     fmode_t                         open_flags;
> > +     struct kref                     kref;
> > +     struct completion               *destroy_comp;
> > +     char                            pathname[NAME_MAX];
> > +     enum rnbd_access_mode           access_mode;
> > +};
> Please indent structure members consistently. Anyway:
Will do.
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thank you!
