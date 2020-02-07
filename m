Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89F81557DE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 13:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGMiM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 07:38:12 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44398 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGMiM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 07:38:12 -0500
Received: by mail-il1-f196.google.com with SMTP id s85so1543958ill.11
        for <linux-rdma@vger.kernel.org>; Fri, 07 Feb 2020 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlKFBQ7tIXDqDtIVBtX+puTjSloO+bHkLEM0ZWQvass=;
        b=UenZ22i/l8xW6VzwH2wVQxiM6XClmE//IliwB9qfkIe0d6312nRuyZ86sNNtiGz/a7
         S8uk0PkQepHNkReZZ2JmyCwe08MeY5sb9rAhotOxt4TcWX0A0lM6G3ZsbxGErJDVyn9z
         wDKTZWaMsdwfONr81Om5sVggYHRyQZJNynF4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlKFBQ7tIXDqDtIVBtX+puTjSloO+bHkLEM0ZWQvass=;
        b=BJOol5Ld7OO/IadXTJMTfg4krDEwhXi1r1dbWniJnCf4w03IZKxXxahw7JUGlanuiW
         zbq5/bFim4ycuwCDXC842oDBhCCmHO0TBr5aNsbhKi1Gt+3uzJDRllpjyNEW2xUFjEJd
         iUWbmKVaPWLYp+9av3exsfuReu7lxgsYVaDkwqM/KssSySjsPo5LN4XbkSiQntahnf6i
         TiGcu1hYSRaUZC6WJfcl/2s59Z1JPP9kJEXJu1M2NfmY7gGIB6qZN/g0oyo4yzgpqZzQ
         Eizqj0HtZyrR+uxgR9qU+3Zk4M+hp4er3az6yH1odgom3+W4mJR3Q4Oo73M8hIVQPLTY
         m6EA==
X-Gm-Message-State: APjAAAWJjtXNE10gK40UwBYQCXIyNDRja1naxxzgaerwh+jSaTzBCLU0
        zZOvBWB83y8sDQqjyIL/VbKqgB9Mt6j5YlpRHvbM2QCFAQA=
X-Google-Smtp-Source: APXvYqwZhk2PEn2ba0s4HLmzWibXq9Z28MkRRfsF4mRFCRmyLSVte6xnGjGmIj1h4fB6JD8PAKgq2gKjQjyf/qBbdus=
X-Received: by 2002:a92:bf10:: with SMTP id z16mr9238850ilh.87.1581079091089;
 Fri, 07 Feb 2020 04:38:11 -0800 (PST)
MIME-Version: 1.0
References: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com> <88498668-9723-9695-b4e7-3384dde76c36@mellanox.com>
In-Reply-To: <88498668-9723-9695-b4e7-3384dde76c36@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Fri, 7 Feb 2020 18:07:34 +0530
Message-ID: <CANjDDBgdX1REcRRKKdqaWNR2Y+Om-Kwb0vm_JuP703m0VLe_6g@mail.gmail.com>
Subject: Re: [PATCH v7] libibverbs: display gid type in ibv_devinfo
To:     Mark Bloch <markb@mellanox.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 6, 2020 at 11:38 AM Mark Bloch <markb@mellanox.com> wrote:
>
>
>
> On 2/5/2020 21:44, Devesh Sharma wrote:
> > It becomes difficult to make out from the output of ibv_devinfo
> > if a particular gid index is RoCE v2 or not.
> >
> > Adding a string to the output of ibv_devinfo -v to display the
> > gid type at the end of gid.
> >
> > The output would look something like below:
> > $ ibv_devinfo -v -d bnxt_re2
> > hca_id: bnxt_re2
> >  transport:             InfiniBand (0)
> >  fw_ver:                216.0.220.0
> >  node_guid:             b226:28ff:fed3:b0f0
> >  sys_image_guid:        b226:28ff:fed3:b0f0
> >   .
> >   .
> >   .
> >   .
> >       phys_state:     LINK_UP (5)
> >       GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> >       GID[  1]:       fe80::b226:28ff:fed3:b0f0, RoCE v2
> >       GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> >       GID[  3]:       ::ffff:192.170.1.101, RoCE v2
> > $
> > $
> > $
> >
> > Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> > Reviewed-by: Leon Romanovsky <leon@kernel.org>
> > Reviewed-by: Gal Pressman <galpress@amazon.com>
> > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  libibverbs/examples/devinfo.c | 61 ++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 12 deletions(-)
> >
> > diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> > index bf53eac..7e2015b 100644
> > --- a/libibverbs/examples/devinfo.c
> > +++ b/libibverbs/examples/devinfo.c
> > @@ -40,6 +40,7 @@
> >  #include <getopt.h>
> >  #include <endian.h>
> >  #include <inttypes.h>
> > +#include <arpa/inet.h>
> >
> >  #include <infiniband/verbs.h>
> >  #include <infiniband/driver.h>
> > @@ -162,12 +163,50 @@ static const char *vl_str(uint8_t vl_num)
> >       }
> >  }
> >
> > -static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
> > +#define DEVINFO_INVALID_GID_TYPE     2
> > +static const char *gid_type_str(enum ibv_gid_type type)
> >  {
> > +     switch (type) {
> > +     case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
>
> You call this function only if link layer is ethernet, why do you need the "IB/" part?
Jason do you have any suggestion here, "IB/ROCE v1" is the standard
string rdma-cm and
/sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/types/* use to
distinguish v2 gid from v1/IB gids.
>
>
> > +     case IBV_GID_TYPE_ROCE_V2: return "RoCE v2";
> > +     default: return "Invalid gid type";
> > +     }
> > +}
> > +
> > +static void print_formated_gid(union ibv_gid *gid, int i,
> > +                            enum ibv_gid_type type, int ll)
> > +{
> > +     char gid_str[INET6_ADDRSTRLEN] = {};
> > +     char str[20] = {};
> > +
> > +     if (ll == IBV_LINK_LAYER_ETHERNET)
> > +             sprintf(str, ", %s", gid_type_str(type));
> > +
> > +     if (type == IBV_GID_TYPE_IB_ROCE_V1)
> > +             printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x%s\n",
> > +                    i, gid->raw[0], gid->raw[1], gid->raw[2],
> > +                    gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
> > +                    gid->raw[7], gid->raw[8], gid->raw[9], gid->raw[10],
> > +                    gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
> > +                    gid->raw[15], str);
> > +
> > +     if (type == IBV_GID_TYPE_ROCE_V2) {
> > +             inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
> > +             printf("\t\t\tGID[%3d]:\t\t%s%s\n", i, gid_str, str);
> > +     }
> > +}
> > +
> > +static int print_all_port_gids(struct ibv_context *ctx,
> > +                            struct ibv_port_attr *port_attr,
> > +                            uint8_t port_num)
> > +{
> > +     enum ibv_gid_type type;
> >       union ibv_gid gid;
> > +     int tbl_len;
> >       int rc = 0;
> >       int i;
> >
> > +     tbl_len = port_attr->gid_tbl_len;
> >       for (i = 0; i < tbl_len; i++) {
> >               rc = ibv_query_gid(ctx, port_num, i, &gid);
> >               if (rc) {
> > @@ -175,17 +214,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
> >                              port_num, i);
> >                       return rc;
> >               }
> > +
> > +             rc = ibv_query_gid_type(ctx, port_num, i, &type);
>
> I really dislike this, what if in the future a new gid type will be added (I know, I know, what are
> the chances :) )
>
> old rdma-core won't display anything in that index (while today it displays anything as long
> as the gid isn't a null gid).
Parav, do you have any suggestions here?
>
> Mark
>
> > +             if (rc) {
> > +                     rc = 0;
> > +                     type = DEVINFO_INVALID_GID_TYPE;
> > +             }
> >               if (!null_gid(&gid))
> > -                     printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
> > -                            i,
> > -                            gid.raw[ 0], gid.raw[ 1],
> > -                            gid.raw[ 2], gid.raw[ 3],
> > -                            gid.raw[ 4], gid.raw[ 5],
> > -                            gid.raw[ 6], gid.raw[ 7],
> > -                            gid.raw[ 8], gid.raw[ 9],
> > -                            gid.raw[10], gid.raw[11],
> > -                            gid.raw[12], gid.raw[13],
> > -                            gid.raw[14], gid.raw[15]);
> > +                     print_formated_gid(&gid, i, type,
> > +                                        port_attr->link_layer);
> >       }
> >       return rc;
> >  }
> > @@ -614,7 +651,7 @@ static int print_hca_cap(struct ibv_device *ib_dev, uint8_t ib_port)
> >                               printf("\t\t\tphys_state:\t\t%s (%d)\n",
> >                                      port_phy_state_str(port_attr.phys_state), port_attr.phys_state);
> >
> > -                     if (print_all_port_gids(ctx, port, port_attr.gid_tbl_len))
> > +                     if (print_all_port_gids(ctx, &port_attr, port))
> >                               goto cleanup;
> >               }
> >               printf("\n");
> >
