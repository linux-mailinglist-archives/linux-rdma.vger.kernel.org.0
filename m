Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A862E363AEC
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 07:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhDSFNR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 01:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSFNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 01:13:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C20C06174A
        for <linux-rdma@vger.kernel.org>; Sun, 18 Apr 2021 22:12:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g17so38366635edm.6
        for <linux-rdma@vger.kernel.org>; Sun, 18 Apr 2021 22:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NSArfkzcXagn1BGtyHWywXg7N29PeN7alpefyJgEziY=;
        b=DjqcgoJfzNPJsIBjt4ZWaqnGSdDe/U2OnY9JNMba8HNg03vHjO4dYKK+2p9yZ1Ii4s
         MuMBb6LJxRInEmhYgCxAe5qAUIDUkONsgdsTb6UrDa1PyMZiYrqU3jSv2gH9t832/nRe
         ZdZDnL6zTasYAguxerMyFMpU/1ih6BGp+VNbt7v5+1wPBJakA9+V7RY7wtjv67uOeIV6
         KiYKcaafHpZkIsYq/erHhAyNda4FeR6UIsNVoHdgF5NnMgR4uQGzKV/lPZo05wywXhkP
         B/8PJzPaPwDD8NJs3ETnNQinUS2+dasKiTygorb4D+Zv327VyM3Z7P9sXexEg2fMLibG
         r7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NSArfkzcXagn1BGtyHWywXg7N29PeN7alpefyJgEziY=;
        b=sq8wfK64SYmGwJ213arYLleExwdWcwKnhKi7ya6QI14qKd3rXLYkLZOj2wJq5CIsQn
         j21gsyu1ePtLU5FqgH9smFd/iBaVLZPh65QVk0KVaKSv21YJRLVddt9RK51WU9NxSueY
         WNpkZXE6KT0p46BtfT4DSaeq09gFIDw7SmJfaQf2C9+LYVgKjnfLKSxQ5H2hSoIpJPps
         s6KsBv+pSVM3X5I6MJ4nVuEvC38/nJAp3iLta0U985w2pPs5CUqHxnzXqPHpLviVyTqH
         1KFiIFyudqitNylYLTcuQO/g+pgZst2mRSdEkn+u+2ZmGtqrYhVC6vZbIB6T4fkCKNFe
         mAbg==
X-Gm-Message-State: AOAM530IylFyoBQ7OyxXzjKJSKpD36bhBdY1QsWAKKPE4rH7lxV/usFa
        R4n45G2vqXPExlLWKPQAFAmbwsymiaLkMV+0khi2LzWhE/k=
X-Google-Smtp-Source: ABdhPJziOKUwH/7Lj2WRiXl156DVW+q2n8kwlylqU4g2z3z+aR291CnUVmuak9fasXUfAGXd/nywRK4wbUK7y2azTck=
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr3962527edb.220.1618809165695;
 Sun, 18 Apr 2021 22:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122402.203388-1-gi-oh.kim@ionos.com> <20210414122402.203388-14-gi-oh.kim@ionos.com>
 <YHvvdskHgQe9gX09@unreal>
In-Reply-To: <YHvvdskHgQe9gX09@unreal>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 19 Apr 2021 07:12:09 +0200
Message-ID: <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
Subject: Re: [PATCHv4 for-next 13/19] block/rnbd-clt: Support polling mode for
 IO latency optimization
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, sagi@grimberg.me,
        Bart Van Assche <bvanassche@acm.org>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 10:36 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Apr 14, 2021 at 02:23:56PM +0200, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > RNBD can make double-queues for irq-mode and poll-mode.
> > For example, on 4-CPU system 8 request-queues are created,
> > 4 for irq-mode and 4 for poll-mode.
> > If the IO has HIPRI flag, the block-layer will call .poll function
> > of RNBD. Then IO is sent to the poll-mode queue.
> > Add optional nr_poll_queues argument for map_devices interface.
> >
> > To support polling of RNBD, RTRS client creates connections
> > for both of irq-mode and direct-poll-mode.
> >
> > For example, on 4-CPU system it could've create 5 connections:
> > con[0] =3D> user message (softirq cq)
> > con[1:4] =3D> softirq cq
> >
> > After this patch, it can create 9 connections:
> > con[0] =3D> user message (softirq cq)
> > con[1:4] =3D> softirq cq
> > con[5:8] =3D> DIRECT-POLL cq
> >
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/block/rnbd/rnbd-clt-sysfs.c    | 56 +++++++++++++----
> >  drivers/block/rnbd/rnbd-clt.c          | 85 +++++++++++++++++++++++---
> >  drivers/block/rnbd/rnbd-clt.h          |  5 +-
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 62 +++++++++++++++----
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
> >  drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
> >  6 files changed, 178 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/r=
nbd-clt-sysfs.c
> > index 49015f428e67..bd111ebceb75 100644
> > --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> > +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> > @@ -34,6 +34,7 @@ enum {
> >       RNBD_OPT_DEV_PATH       =3D 1 << 2,
> >       RNBD_OPT_ACCESS_MODE    =3D 1 << 3,
> >       RNBD_OPT_SESSNAME       =3D 1 << 6,
> > +     RNBD_OPT_NR_POLL_QUEUES =3D 1 << 7,
> >  };
> >
> >  static const unsigned int rnbd_opt_mandatory[] =3D {
> > @@ -42,12 +43,13 @@ static const unsigned int rnbd_opt_mandatory[] =3D =
{
> >  };
> >
> >  static const match_table_t rnbd_opt_tokens =3D {
> > -     {RNBD_OPT_PATH,         "path=3D%s"       },
> > -     {RNBD_OPT_DEV_PATH,     "device_path=3D%s"},
> > -     {RNBD_OPT_DEST_PORT,    "dest_port=3D%d"  },
> > -     {RNBD_OPT_ACCESS_MODE,  "access_mode=3D%s"},
> > -     {RNBD_OPT_SESSNAME,     "sessname=3D%s"   },
> > -     {RNBD_OPT_ERR,          NULL            },
> > +     {RNBD_OPT_PATH,                 "path=3D%s"               },
> > +     {RNBD_OPT_DEV_PATH,             "device_path=3D%s"        },
> > +     {RNBD_OPT_DEST_PORT,            "dest_port=3D%d"          },
> > +     {RNBD_OPT_ACCESS_MODE,          "access_mode=3D%s"        },
> > +     {RNBD_OPT_SESSNAME,             "sessname=3D%s"           },
> > +     {RNBD_OPT_NR_POLL_QUEUES,       "nr_poll_queues=3D%d"     },
> > +     {RNBD_OPT_ERR,                  NULL                    },
> >  };
> >
> >  struct rnbd_map_options {
> > @@ -57,6 +59,7 @@ struct rnbd_map_options {
> >       char *pathname;
> >       u16 *dest_port;
> >       enum rnbd_access_mode *access_mode;
> > +     u32 *nr_poll_queues;
> >  };
> >
> >  static int rnbd_clt_parse_map_options(const char *buf, size_t max_path=
_cnt,
> > @@ -68,7 +71,7 @@ static int rnbd_clt_parse_map_options(const char *buf=
, size_t max_path_cnt,
> >       int opt_mask =3D 0;
> >       int token;
> >       int ret =3D -EINVAL;
> > -     int i, dest_port;
> > +     int i, dest_port, nr_poll_queues;
> >       int p_cnt =3D 0;
> >
> >       options =3D kstrdup(buf, GFP_KERNEL);
> > @@ -178,6 +181,19 @@ static int rnbd_clt_parse_map_options(const char *=
buf, size_t max_path_cnt,
> >                       kfree(p);
> >                       break;
> >
> > +             case RNBD_OPT_NR_POLL_QUEUES:
> > +                     if (match_int(args, &nr_poll_queues) || nr_poll_q=
ueues < -1 ||
> > +                         nr_poll_queues > (int)nr_cpu_ids) {
> > +                             pr_err("bad nr_poll_queues parameter '%d'=
\n",
> > +                                    nr_poll_queues);
> > +                             ret =3D -EINVAL;
> > +                             goto out;
> > +                     }
> > +                     if (nr_poll_queues =3D=3D -1)
> > +                             nr_poll_queues =3D nr_cpu_ids;
> > +                     *opt->nr_poll_queues =3D nr_poll_queues;
> > +                     break;
> > +
> >               default:
> >                       pr_err("map_device: Unknown parameter or missing =
value '%s'\n",
> >                              p);
> > @@ -227,6 +243,20 @@ static ssize_t state_show(struct kobject *kobj,
> >
> >  static struct kobj_attribute rnbd_clt_state_attr =3D __ATTR_RO(state);
> >
> > +static ssize_t nr_poll_queues_show(struct kobject *kobj,
> > +                                struct kobj_attribute *attr, char *pag=
e)
> > +{
> > +     struct rnbd_clt_dev *dev;
> > +
> > +     dev =3D container_of(kobj, struct rnbd_clt_dev, kobj);
> > +
> > +     return snprintf(page, PAGE_SIZE, "%d\n",
> > +                     dev->nr_poll_queues);
> > +}
>
> Didn't Greg ask you to use sysfs_emit() here?

Right, I missed it.
I will fix it for next round.


>
> > +
> > +static struct kobj_attribute rnbd_clt_nr_poll_queues =3D
> > +     __ATTR_RO(nr_poll_queues);
> > +
> >  static ssize_t mapping_path_show(struct kobject *kobj,
> >                                struct kobj_attribute *attr, char *page)
> >  {
> > @@ -421,6 +451,7 @@ static struct attribute *rnbd_dev_attrs[] =3D {
> >       &rnbd_clt_state_attr.attr,
> >       &rnbd_clt_session_attr.attr,
> >       &rnbd_clt_access_mode.attr,
> > +     &rnbd_clt_nr_poll_queues.attr,
> >       NULL,
> >  };
> >
> > @@ -469,7 +500,7 @@ static ssize_t rnbd_clt_map_device_show(struct kobj=
ect *kobj,
> >                                        char *page)
> >  {
> >       return scnprintf(page, PAGE_SIZE,
> > -                      "Usage: echo \"[dest_port=3Dserver port number] =
sessname=3D<name of the rtrs session> path=3D<[srcaddr@]dstaddr> [path=3D<[=
srcaddr@]dstaddr>] device_path=3D<full path on remote side> [access_mode=3D=
<ro|rw|migration>]\" > %s\n\naddr ::=3D [ ip:<ipv4> | ip:<ipv6> | gid:<gid>=
 ]\n",
> > +                      "Usage: echo \"[dest_port=3Dserver port number] =
sessname=3D<name of the rtrs session> path=3D<[srcaddr@]dstaddr> [path=3D<[=
srcaddr@]dstaddr>] device_path=3D<full path on remote side> [access_mode=3D=
<ro|rw|migration>] [nr_poll_queues=3D<number of queues>]\" > %s\n\naddr ::=
=3D [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
> >                        attr->attr.name);
> >  }
> >
> > @@ -541,6 +572,7 @@ static ssize_t rnbd_clt_map_device_store(struct kob=
ject *kobj,
> >       char sessname[NAME_MAX];
> >       enum rnbd_access_mode access_mode =3D RNBD_ACCESS_RW;
> >       u16 port_nr =3D RTRS_PORT;
> > +     u32 nr_poll_queues =3D 0;
> >
> >       struct sockaddr_storage *addrs;
> >       struct rtrs_addr paths[6];
> > @@ -552,6 +584,7 @@ static ssize_t rnbd_clt_map_device_store(struct kob=
ject *kobj,
> >       opt.pathname =3D pathname;
> >       opt.dest_port =3D &port_nr;
> >       opt.access_mode =3D &access_mode;
> > +     opt.nr_poll_queues =3D &nr_poll_queues;
> >       addrs =3D kcalloc(ARRAY_SIZE(paths) * 2, sizeof(*addrs), GFP_KERN=
EL);
> >       if (!addrs)
> >               return -ENOMEM;
> > @@ -565,12 +598,13 @@ static ssize_t rnbd_clt_map_device_store(struct k=
object *kobj,
> >       if (ret)
> >               goto out;
> >
> > -     pr_info("Mapping device %s on session %s, (access_mode: %s)\n",
> > +     pr_info("Mapping device %s on session %s, (access_mode: %s, nr_po=
ll_queues: %d)\n",
> >               pathname, sessname,
> > -             rnbd_access_mode_str(access_mode));
> > +             rnbd_access_mode_str(access_mode),
> > +             nr_poll_queues);
> >
> >       dev =3D rnbd_clt_map_device(sessname, paths, path_cnt, port_nr, p=
athname,
> > -                               access_mode);
> > +                               access_mode, nr_poll_queues);
> >       if (IS_ERR(dev)) {
> >               ret =3D PTR_ERR(dev);
> >               goto out;
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-cl=
t.c
> > index 9b44aac680d5..63719ec04d58 100644
> > --- a/drivers/block/rnbd/rnbd-clt.c
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -1165,9 +1165,54 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_=
hw_ctx *hctx,
> >       return ret;
> >  }
> >
> > +static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx)
> > +{
> > +     struct rnbd_queue *q =3D hctx->driver_data;
> > +     struct rnbd_clt_dev *dev =3D q->dev;
> > +     int cnt;
> > +
> > +     cnt =3D rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num)=
;
> > +     return cnt;
> > +}
> > +
> > +static int rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
> > +{
> > +     struct rnbd_clt_session *sess =3D set->driver_data;
> > +
> > +     /* shared read/write queues */
> > +     set->map[HCTX_TYPE_DEFAULT].nr_queues =3D num_online_cpus();
> > +     set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
> > +     set->map[HCTX_TYPE_READ].nr_queues =3D num_online_cpus();
> > +     set->map[HCTX_TYPE_READ].queue_offset =3D 0;
> > +     blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> > +     blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> > +
> > +     if (sess->nr_poll_queues) {
> > +             /* dedicated queue for poll */
> > +             set->map[HCTX_TYPE_POLL].nr_queues =3D sess->nr_poll_queu=
es;
> > +             set->map[HCTX_TYPE_POLL].queue_offset =3D set->map[HCTX_T=
YPE_READ].queue_offset +
> > +                     set->map[HCTX_TYPE_READ].nr_queues;
> > +             blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> > +             pr_info("[session=3D%s] mapped %d/%d/%d default/read/poll=
 queues.\n",
> > +                     sess->sessname,
> > +                     set->map[HCTX_TYPE_DEFAULT].nr_queues,
> > +                     set->map[HCTX_TYPE_READ].nr_queues,
> > +                     set->map[HCTX_TYPE_POLL].nr_queues);
> > +     } else {
> > +             pr_info("[session=3D%s] mapped %d/%d default/read queues.=
\n",
> > +                     sess->sessname,
> > +                     set->map[HCTX_TYPE_DEFAULT].nr_queues,
> > +                     set->map[HCTX_TYPE_READ].nr_queues);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static struct blk_mq_ops rnbd_mq_ops =3D {
> >       .queue_rq       =3D rnbd_queue_rq,
> >       .complete       =3D rnbd_softirq_done_fn,
> > +     .map_queues     =3D rnbd_rdma_map_queues,
> > +     .poll           =3D rnbd_rdma_poll,
> >  };
> >
> >  static int setup_mq_tags(struct rnbd_clt_session *sess)
> > @@ -1181,7 +1226,15 @@ static int setup_mq_tags(struct rnbd_clt_session=
 *sess)
> >       tag_set->flags          =3D BLK_MQ_F_SHOULD_MERGE |
> >                                 BLK_MQ_F_TAG_QUEUE_SHARED;
> >       tag_set->cmd_size       =3D sizeof(struct rnbd_iu) + RNBD_RDMA_SG=
L_SIZE;
> > -     tag_set->nr_hw_queues   =3D num_online_cpus();
> > +
> > +     /* for HCTX_TYPE_DEFAULT, HCTX_TYPE_READ, HCTX_TYPE_POLL */
> > +     tag_set->nr_maps        =3D sess->nr_poll_queues ? HCTX_MAX_TYPES=
 : 2;
> > +     /*
> > +      * HCTX_TYPE_DEFAULT and HCTX_TYPE_READ share one set of queues
> > +      * others are for HCTX_TYPE_POLL
> > +      */
> > +     tag_set->nr_hw_queues   =3D num_online_cpus() + sess->nr_poll_que=
ues;
> > +     tag_set->driver_data    =3D sess;
> >
> >       return blk_mq_alloc_tag_set(tag_set);
> >  }
> > @@ -1189,7 +1242,7 @@ static int setup_mq_tags(struct rnbd_clt_session =
*sess)
> >  static struct rnbd_clt_session *
> >  find_and_get_or_create_sess(const char *sessname,
> >                           const struct rtrs_addr *paths,
> > -                         size_t path_cnt, u16 port_nr)
> > +                         size_t path_cnt, u16 port_nr, u32 nr_poll_que=
ues)
> >  {
> >       struct rnbd_clt_session *sess;
> >       struct rtrs_attrs attrs;
> > @@ -1198,6 +1251,17 @@ find_and_get_or_create_sess(const char *sessname=
,
> >       struct rtrs_clt_ops rtrs_ops;
> >
> >       sess =3D find_or_create_sess(sessname, &first);
> > +     if (sess =3D=3D ERR_PTR(-ENOMEM))
> > +             return ERR_PTR(-ENOMEM);
> > +     else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess-=
>nr_poll_queues)) {
> > +             /*
> > +              * A device MUST have its own session to use the polling-=
mode.
> > +              * It must fail to map new device with the same session.
> > +              */
> > +             err =3D -EINVAL;
> > +             goto put_sess;
> > +     }
> > +
> >       if (!first)
> >               return sess;
> >
> > @@ -1219,7 +1283,7 @@ find_and_get_or_create_sess(const char *sessname,
> >                                  0, /* Do not use pdu of rtrs */
> >                                  RECONNECT_DELAY, BMAX_SEGMENTS,
> >                                  BLK_MAX_SEGMENT_SIZE,
> > -                                MAX_RECONNECTS);
> > +                                MAX_RECONNECTS, nr_poll_queues);
> >       if (IS_ERR(sess->rtrs)) {
> >               err =3D PTR_ERR(sess->rtrs);
> >               goto wake_up_and_put;
> > @@ -1227,6 +1291,7 @@ find_and_get_or_create_sess(const char *sessname,
> >       rtrs_clt_query(sess->rtrs, &attrs);
> >       sess->max_io_size =3D attrs.max_io_size;
> >       sess->queue_depth =3D attrs.queue_depth;
> > +     sess->nr_poll_queues =3D nr_poll_queues;
> >
> >       err =3D setup_mq_tags(sess);
> >       if (err)
> > @@ -1370,7 +1435,8 @@ static int rnbd_client_setup_device(struct rnbd_c=
lt_dev *dev)
> >
> >  static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
> >                                     enum rnbd_access_mode access_mode,
> > -                                   const char *pathname)
> > +                                   const char *pathname,
> > +                                   u32 nr_poll_queues)
> >  {
> >       struct rnbd_clt_dev *dev;
> >       int ret;
> > @@ -1379,7 +1445,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_=
clt_session *sess,
> >       if (!dev)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     dev->hw_queues =3D kcalloc(nr_cpu_ids, sizeof(*dev->hw_queues),
> > +     dev->hw_queues =3D kcalloc(nr_cpu_ids /* softirq */ + nr_poll_que=
ues /* poll */,
>
> Please don't add comments in the middle of function call.

Ok, I will fix it for next round.


>
> > +                              sizeof(*dev->hw_queues),
> >                                GFP_KERNEL);
> >       if (!dev->hw_queues) {
> >               ret =3D -ENOMEM;
> > @@ -1405,6 +1472,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_=
clt_session *sess,
> >       dev->clt_device_id      =3D ret;
> >       dev->sess               =3D sess;
> >       dev->access_mode        =3D access_mode;
> > +     dev->nr_poll_queues     =3D nr_poll_queues;
> >       mutex_init(&dev->lock);
> >       refcount_set(&dev->refcount, 1);
> >       dev->dev_state =3D DEV_STATE_INIT;
> > @@ -1491,7 +1559,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const ch=
ar *sessname,
> >                                          struct rtrs_addr *paths,
> >                                          size_t path_cnt, u16 port_nr,
> >                                          const char *pathname,
> > -                                        enum rnbd_access_mode access_m=
ode)
> > +                                        enum rnbd_access_mode access_m=
ode,
> > +                                        u32 nr_poll_queues)
> >  {
> >       struct rnbd_clt_session *sess;
> >       struct rnbd_clt_dev *dev;
> > @@ -1500,11 +1569,11 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const =
char *sessname,
> >       if (unlikely(exists_devpath(pathname, sessname)))
> >               return ERR_PTR(-EEXIST);
> >
> > -     sess =3D find_and_get_or_create_sess(sessname, paths, path_cnt, p=
ort_nr);
> > +     sess =3D find_and_get_or_create_sess(sessname, paths, path_cnt, p=
ort_nr, nr_poll_queues);
> >       if (IS_ERR(sess))
> >               return ERR_CAST(sess);
> >
> > -     dev =3D init_dev(sess, access_mode, pathname);
> > +     dev =3D init_dev(sess, access_mode, pathname, nr_poll_queues);
> >       if (IS_ERR(dev)) {
> >               pr_err("map_device: failed to map device '%s' from sessio=
n %s, can't initialize device, err: %ld\n",
> >                      pathname, sess->sessname, PTR_ERR(dev));
> > diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-cl=
t.h
> > index 714d426b449b..451e7383738f 100644
> > --- a/drivers/block/rnbd/rnbd-clt.h
> > +++ b/drivers/block/rnbd/rnbd-clt.h
> > @@ -90,6 +90,7 @@ struct rnbd_clt_session {
> >       int                     queue_depth;
> >       u32                     max_io_size;
> >       struct blk_mq_tag_set   tag_set;
> > +     u32                     nr_poll_queues;
> >       struct mutex            lock; /* protects state and devs_list */
> >       struct list_head        devs_list; /* list of struct rnbd_clt_dev=
 */
> >       refcount_t              refcount;
> > @@ -118,6 +119,7 @@ struct rnbd_clt_dev {
> >       enum rnbd_clt_dev_state dev_state;
> >       char                    *pathname;
> >       enum rnbd_access_mode   access_mode;
> > +     u32                     nr_poll_queues;
> >       bool                    read_only;
> >       bool                    rotational;
> >       bool                    wc;
> > @@ -147,7 +149,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char=
 *sessname,
> >                                          struct rtrs_addr *paths,
> >                                          size_t path_cnt, u16 port_nr,
> >                                          const char *pathname,
> > -                                        enum rnbd_access_mode access_m=
ode);
> > +                                        enum rnbd_access_mode access_m=
ode,
> > +                                        u32 nr_poll_queues);
> >  int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
> >                          const struct attribute *sysfs_self);
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniban=
d/ulp/rtrs/rtrs-clt.c
> > index 7efd49bdc78c..467d135a82cf 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -174,7 +174,7 @@ struct rtrs_clt_con *rtrs_permit_to_clt_con(struct =
rtrs_clt_sess *sess,
> >       int id =3D 0;
> >
> >       if (likely(permit->con_type =3D=3D RTRS_IO_CON))
> > -             id =3D (permit->cpu_id % (sess->s.con_num - 1)) + 1;
> > +             id =3D (permit->cpu_id % (sess->s.irq_con_num - 1)) + 1;
> >
> >       return to_clt_con(sess->s.con[id]);
> >  }
> > @@ -1400,23 +1400,29 @@ static void rtrs_clt_close_work(struct work_str=
uct *work);
> >  static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
> >                                        const struct rtrs_addr *path,
> >                                        size_t con_num, u16 max_segments=
,
> > -                                      size_t max_segment_size)
> > +                                      size_t max_segment_size, u32 nr_=
poll_queues)
> >  {
> >       struct rtrs_clt_sess *sess;
> >       int err =3D -ENOMEM;
> >       int cpu;
> > +     size_t total_con;
> >
> >       sess =3D kzalloc(sizeof(*sess), GFP_KERNEL);
> >       if (!sess)
> >               goto err;
> >
> > -     /* Extra connection for user messages */
> > -     con_num +=3D 1;
> > -
> > -     sess->s.con =3D kcalloc(con_num, sizeof(*sess->s.con), GFP_KERNEL=
);
> > +     /*
> > +      * irqmode and poll
> > +      * +1: Extra connection for user messages
> > +      */
> > +     total_con =3D con_num + nr_poll_queues + 1;
> > +     sess->s.con =3D kcalloc(total_con, sizeof(*sess->s.con), GFP_KERN=
EL);
> >       if (!sess->s.con)
> >               goto err_free_sess;
> >
> > +     sess->s.con_num =3D total_con;
> > +     sess->s.irq_con_num =3D con_num + 1;
> > +
> >       sess->stats =3D kzalloc(sizeof(*sess->stats), GFP_KERNEL);
> >       if (!sess->stats)
> >               goto err_free_con;
> > @@ -1435,7 +1441,6 @@ static struct rtrs_clt_sess *alloc_sess(struct rt=
rs_clt *clt,
> >               memcpy(&sess->s.src_addr, path->src,
> >                      rdma_addr_size((struct sockaddr *)path->src));
> >       strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname)=
);
> > -     sess->s.con_num =3D con_num;
> >       sess->clt =3D clt;
> >       sess->max_pages_per_mr =3D max_segments * max_segment_size >> 12;
> >       init_waitqueue_head(&sess->state_wq);
> > @@ -1576,9 +1581,14 @@ static int create_con_cq_qp(struct rtrs_clt_con =
*con)
> >       }
> >       cq_size =3D max_send_wr + max_recv_wr;
> >       cq_vector =3D con->cpu % sess->s.dev->ib_dev->num_comp_vectors;
> > -     err =3D rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
> > -                              cq_vector, cq_size, max_send_wr,
> > -                              max_recv_wr, IB_POLL_SOFTIRQ);
> > +     if (con->c.cid >=3D sess->s.irq_con_num)
> > +             err =3D rtrs_cq_qp_create(&sess->s, &con->c, sess->max_se=
nd_sge,
> > +                                     cq_vector, cq_size, max_send_wr,
> > +                                     max_recv_wr, IB_POLL_DIRECT);
> > +     else
> > +             err =3D rtrs_cq_qp_create(&sess->s, &con->c, sess->max_se=
nd_sge,
> > +                                     cq_vector, cq_size, max_send_wr,
> > +                                     max_recv_wr, IB_POLL_SOFTIRQ);
> >       /*
> >        * In case of error we do not bother to clean previous allocation=
s,
> >        * since destroy_con_cq_qp() must be called.
> > @@ -2631,6 +2641,7 @@ static void free_clt(struct rtrs_clt *clt)
> >   * @max_segment_size: Max. size of one segment
> >   * @max_reconnect_attempts: Number of times to reconnect on error befo=
re giving
> >   *                       up, 0 for * disabled, -1 for forever
> > + * @nr_poll_queues: number of polling mode connection using IB_POLL_DI=
RECT flag
> >   *
> >   * Starts session establishment with the rtrs_server. The function can=
 block
> >   * up to ~2000ms before it returns.
> > @@ -2644,7 +2655,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_op=
s *ops,
> >                                size_t pdu_sz, u8 reconnect_delay_sec,
> >                                u16 max_segments,
> >                                size_t max_segment_size,
> > -                              s16 max_reconnect_attempts)
> > +                              s16 max_reconnect_attempts, u32 nr_poll_=
queues)
> >  {
> >       struct rtrs_clt_sess *sess, *tmp;
> >       struct rtrs_clt *clt;
> > @@ -2662,7 +2673,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_op=
s *ops,
> >               struct rtrs_clt_sess *sess;
> >
> >               sess =3D alloc_sess(clt, &paths[i], nr_cpu_ids,
> > -                               max_segments, max_segment_size);
> > +                               max_segments, max_segment_size, nr_poll=
_queues);
> >               if (IS_ERR(sess)) {
> >                       err =3D PTR_ERR(sess);
> >                       goto close_all_sess;
> > @@ -2887,6 +2898,31 @@ int rtrs_clt_request(int dir, struct rtrs_clt_re=
q_ops *ops,
> >  }
> >  EXPORT_SYMBOL(rtrs_clt_request);
> >
> > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
> > +{
> > +     int cnt;
> > +     struct rtrs_con *con;
> > +     struct rtrs_clt_sess *sess;
> > +     struct path_it it;
> > +
> > +     rcu_read_lock();
> > +     for (path_it_init(&it, clt);
> > +          (sess =3D it.next_path(&it)) && it.i < it.clt->paths_num; it=
.i++) {
> > +             if (unlikely(READ_ONCE(sess->state) !=3D RTRS_CLT_CONNECT=
ED))
>
> We talked about useless likely/unlikely in your workloads.

Right, I've made a patch to remove all likely/unlikely
and will send with the next patch set.

I thought it could be better for review to keep the patches
in the patch set. So if this set is applied, I will send a small patch set
to remove likely/unlikely and do some cleanup.

>
> > +                     continue;
> > +
> > +             con =3D sess->s.con[index + 1];
> > +             cnt =3D ib_process_cq_direct(con->cq, -1);
> > +             if (likely(cnt))
> > +                     break;
> > +     }
> > +     path_it_deinit(&it);
> > +     rcu_read_unlock();
> > +
> > +     return cnt;
> > +}
> > +EXPORT_SYMBOL(rtrs_clt_rdma_cq_direct);
> > +
> >  /**
> >   * rtrs_clt_query() - queries RTRS session attributes
> >   *@clt: session pointer
> > @@ -2916,7 +2952,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_c=
lt *clt,
> >       int err;
> >
> >       sess =3D alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments,
> > -                       clt->max_segment_size);
> > +                       clt->max_segment_size, 0);
> >       if (IS_ERR(sess))
> >               return PTR_ERR(sess);
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniban=
d/ulp/rtrs/rtrs-pri.h
> > index 8caad0a2322b..00eb45053339 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > @@ -101,6 +101,7 @@ struct rtrs_sess {
> >       uuid_t                  uuid;
> >       struct rtrs_con **con;
> >       unsigned int            con_num;
> > +     unsigned int            irq_con_num;
> >       unsigned int            recon_cnt;
> >       struct rtrs_ib_dev      *dev;
> >       int                     dev_ref;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ul=
p/rtrs/rtrs.h
> > index 2db1b5eb3ab0..f891fbe7abe6 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs.h
> > @@ -59,7 +59,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *o=
ps,
> >                                size_t pdu_sz, u8 reconnect_delay_sec,
> >                                u16 max_segments,
> >                                size_t max_segment_size,
> > -                              s16 max_reconnect_attempts);
> > +                              s16 max_reconnect_attempts, u32 nr_poll_=
queues);
> >
> >  void rtrs_clt_close(struct rtrs_clt *sess);
> >
> > @@ -103,6 +103,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_o=
ps *ops,
> >                    struct rtrs_clt *sess, struct rtrs_permit *permit,
> >                    const struct kvec *vec, size_t nr, size_t len,
> >                    struct scatterlist *sg, unsigned int sg_cnt);
> > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index);
> >
> >  /**
> >   * rtrs_attrs - RTRS session attributes
> > --
> > 2.25.1
> >

Thank you for the review.
I will send V5 soon.
