Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480A413291C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAGOk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 09:40:58 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33881 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 09:40:57 -0500
Received: by mail-il1-f195.google.com with SMTP id s15so45946798iln.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psKIv5YXGmKAgyjaeMizGcajOmm44u8MIetgyrq+BDc=;
        b=ePpI9i4EOMN0a7BCeoLA7yDM3URjW0iAgbDyXBx3G2AolnnhWvXcK6ins8bx7nTmIB
         BRs9iCZe9a/9ATwdF2gMbnFoarUfZrd+y5YxXMndwHo3VvSBFITjYLMfG/rDaQG2QiCs
         oFPBY53+clp/r1Ld0ynOqGDtzIquoceVbBabpszuICqec1JsP3DXZqhQ4L7YRwwnJ+Hf
         0naN2RxeUY76+BlzyWzjAjePz9IKmuuSK6vFpwK04xRSlxK0DNDQKgJU3Gepc6OtrTYg
         oxyZGnh8igqX4piZXPaScFdoiA1386roAocpXXAh6mm7vDuCJxfHadFqUDKB/2Ia5G+C
         bUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psKIv5YXGmKAgyjaeMizGcajOmm44u8MIetgyrq+BDc=;
        b=STwROtKuY8zEQBJg8UhCd40EfwTlQlLFVDPHrKnZ8wd//tjzOrnjzVb4lR12Fvm6ll
         4EA584FvUNx3NGKHSUrqrklnqyRn9rZYX/Xf1TAcSRVCp77Y1chi1SOxMpqrTtigDk9j
         zcUitL7pnnl8Sh0LDmag39MihvJ572UsEXOkSjXGFBsAk9dODhgIvBabEH76V3asigg7
         Rctp3gdqJR+kgad+nyBnumasTNZK7/bN9F6a5f1X4EuaOeeMUvUbgDrQ8Rdlp1AyJ1et
         di/EYN3ilf/KsKqLYTL5Q6KvvSFLUej0Rd27sd0lUpPmHTDkodN2XO7xmXWP3gQuwE/E
         eeIw==
X-Gm-Message-State: APjAAAUCpFLryUm0W58lVeQTitbR5+emyRt9CoAsPlr1oo7lgm37UFx7
        dMSr0rC6WWmld98On811dBj5jShCGWLOSemKVboggA==
X-Google-Smtp-Source: APXvYqwMC0erWWtIsqyc4T8qm/Eia8gkKxtIKyWyZSHwjsrCwcu2igCtDGNgBdC5EjoWvAhfcVFGCmKQwbdELcrGjRM=
X-Received: by 2002:a92:1090:: with SMTP id 16mr87933739ilq.298.1578408057283;
 Tue, 07 Jan 2020 06:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-13-jinpuwang@gmail.com>
 <6584a511-6d4d-e0e3-453a-c55256bf023b@acm.org>
In-Reply-To: <6584a511-6d4d-e0e3-453a-c55256bf023b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 15:40:46 +0100
Message-ID: <CAMGffE=y14ihqk49k9drCx1Fm2HNzszAr=p-wjXx=T_TpeMqUA@mail.gmail.com>
Subject: Re: [PATCH v6 12/25] rtrs: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 11:06 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +static struct kobj_attribute rtrs_srv_disconnect_attr =
> > +     __ATTR(disconnect, 0644,
> > +            rtrs_srv_disconnect_show, rtrs_srv_disconnect_store);
>
> Could __ATTR_RW() have been used here?
>
> > +static struct kobj_attribute rtrs_srv_hca_port_attr =
> > +     __ATTR(hca_port, 0444, rtrs_srv_hca_port_show, NULL);
>
> Could __ATTR_RO() have been used here?
>
> Thanks,
>
> Bart.
both case can be used, but I prefer to keep the rtrs_srv prefix.
Thanks Bart.
