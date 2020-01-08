Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B258A134360
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 14:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAHNGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 08:06:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33344 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgAHNGj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 08:06:39 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so3140903ioh.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLxLERPumeN8sJpIDdpa4Drgsn9GaWWrGbgvRcWSe2M=;
        b=AoSoWPhEGrh+TRuofKiCzp+l09IO4FiB98EE2yXg+ejc27NTJJA8bvyvXeDaBOVBMo
         E/AIvsl7qbTplYuzjuIG4nQW8zHudVkX5UVgIvXzc8S2nlzTT5sJgsFh0naJ4l15kPlL
         yfPn30xfs4KAzs56QMBRPkjcsypCytvrc0Wrm2w5jtT4nClsYM+Q5uM9cqmmkIyxVBYn
         7LrxzCfHX+69d0crOg/LOLbpt2yagkZ+8H9HLimtcsn702huUDM9df8awvvkpsuOpUCz
         j5KgcN2Qn64/wzCy/RejeTICIPUdRRMQsh+XfqpGEwiBvCLV+9GcpVbpXBlRwRiltsOA
         eiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLxLERPumeN8sJpIDdpa4Drgsn9GaWWrGbgvRcWSe2M=;
        b=WA1NZCgubDXj5YgumpORmyRI1FhUHPV23VMbF2025k7+OdevsrhtZUUGmCV6hwMYQW
         jrO0Gp5Zt0lq9Yn8xWHj8ccWxvUN2LfqHTtxkHdUlrZTQhdzV4SiU1Nc/TUoFoVVKynm
         c07j9rtk2Xf/ke83qxVHz3ZfSdTYToqc7Pn3fWX233ezZoLCqZTJEhlny7NDgr9hFUEm
         RziI8Ym1xA8b6pFN1TVDF7Z4xOssVJZmZV7ld5eqmnLjtHukgp2dhINUH70li7dcfVRc
         fQNtFv4cecJzXSQX+EawjAqSf7CnRTHa9MWOEPqUw/Y5D66mr1QWha2zX20Rs3HzHhjg
         FDeg==
X-Gm-Message-State: APjAAAW4+V6Xh8w6+tNtDaHXSnb2wDvV8J+E0CUg5a7QqLWsguaQzrby
        IrnZmHZve8/AH/Aex4FKjif/D7aYi1PihYTs8rvA7A==
X-Google-Smtp-Source: APXvYqwRtCSmNpIp17l1ZaItYRqohple3ymzlbMbTRvunpbxvAJjVh/A16oxOX/Io0WHbefu7bLHsIlOEaGh0+jG6zk=
X-Received: by 2002:a02:6957:: with SMTP id e84mr3915562jac.11.1578488798382;
 Wed, 08 Jan 2020 05:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-19-jinpuwang@gmail.com>
 <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org>
In-Reply-To: <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 14:06:27 +0100
Message-ID: <CAMGffEmRF+2SZ5Nf3at9SohZXTT3siakBYoZpErN=Tr_PCA9uw@mail.gmail.com>
Subject: Re: [PATCH v6 18/25] rnbd: client: sysfs interface functions
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

On Fri, Jan 3, 2020 at 1:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +static const match_table_t rnbd_opt_tokens = {
> > +     {       RNBD_OPT_PATH,          "path=%s"               },
> > +     {       RNBD_OPT_DEV_PATH,      "device_path=%s"        },
> > +     {       RNBD_OPT_ACCESS_MODE,   "access_mode=%s"        },
> > +     {       RNBD_OPT_SESSNAME,      "sessname=%s"           },
> > +     {       RNBD_OPT_ERR,           NULL                    },
> > +};
>
>
> Please follow the example of other kernel code and change
> "{<tab>...<tab>}" into "{ ... }".
ok.
>
> > +/* remove new line from string */
> > +static void strip(char *s)
> > +{
> > +     char *p = s;
> > +
> > +     while (*s != '\0') {
> > +             if (*s != '\n')
> > +                     *p++ = *s++;
> > +             else
> > +                     ++s;
> > +     }
> > +     *p = '\0';
> > +}
>
> Does this function change a multiline string into a single line? I'm not
> sure that is how sysfs input should be processed ... Is this perhaps
> what you want?
>
> static inline void kill_final_newline(char *str)
> {
>         char *newline = strrchr(str, '\n');
>
>         if (newline && !newline[1])
>                 *newline = 0;
probably you meant "*newline = '\0'"

Your version only removes the last newline, our version removes all
the newlines in the string.

> }
>
> > +static struct kobj_attribute rnbd_clt_map_device_attr =
> > +     __ATTR(map_device, 0644,
> > +            rnbd_clt_map_device_show, rnbd_clt_map_device_store);
>
> Could __ATTR_RW() have been used here?
As replied in other emails, it can be used, but we prefer to keep the
prefix part.
>
> Thanks,
>
> Bart.
Thanks Bart
