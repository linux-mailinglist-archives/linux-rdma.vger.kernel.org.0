Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAF13E0EF
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 17:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAPQqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 11:46:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35358 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgAPQqc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 11:46:32 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so22622772iob.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJY5xe9Ysv/Trt2J4uQVQbz7IEedq3o9ZStDmdgZQBM=;
        b=B5MN/6VyvH1kI71/vmtCGU5iZcGmK6/xnkQE+F52KT70d6YZEmmoqW8WxTsQxQxGA1
         e1AM0+eQSC4nrv6AchXlj1HjeRZ9k4wJrHTn/75SoN8LiR7dh+z12xwkOrrn9Okg7qlg
         5xjF32bcqRc44aKhhmdUbk61YkbAObbdZeq00S6PjRP79vj1M2691L1AWXEYzt3ZLOoW
         t0URFR12N+4v1QwdyTif3/HV+5BOSkCQ/WTnBJzGJH2la9nWswrkIcCMIS71KGJhkACb
         r1ke6fvKZ529y8X3MdK0T8EF8QE9MxEuCtJJI9mlSSfDcxShKk+Fh/RrLjiKS1LGAori
         p8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJY5xe9Ysv/Trt2J4uQVQbz7IEedq3o9ZStDmdgZQBM=;
        b=LTgskjEUiCIpF1YCeEdOCWd8QCMcleTD1zdzCZcbIdR1kT93v+N3pnzc/r45Uto+1w
         GPYG1Lo7y00VchQuIKavYgfW0Gb24RgR7vEVKfhpVuBh6AalMbtAzigv2hPHAlxVsEYL
         xXHNTsSA9NR1lOP6imrRqJ/Ku5XQZSfSJ1LJ4w0h3LIzEPakPs+9OV06Pg4d+OcJZ6Im
         JMU7IhlCFaNTbZQ9tefP4Ag5YxlJkNB+BtQFgcBRkQkZ1ll4i2NUDdNJwafntlE6XVcH
         t6pcJiCrcOSLoV4jjcoSi7fCEW+ZpSb3+tXu2d9RMS7lC0k66TEwfJVrCDDDSUy5Xmo3
         5x+Q==
X-Gm-Message-State: APjAAAUfXdRCvPpYoXC9llX7Iw8WHcVwaWoGzZp2TRiqM7nngXerHNxH
        1ksohfqog4bXUb+jubTnTjrF0dQTQQQ4p7FmpspBYw==
X-Google-Smtp-Source: APXvYqzoHOCS3KCr9ah+GmG1zsSKl8jLwE9QJhuA99zKsCdAoEn6a8Nd1WxpJQXAjuGCcA7Js4OFbdBQgPzdWrLS0Y4=
X-Received: by 2002:a6b:d214:: with SMTP id q20mr20896413iob.298.1579193191098;
 Thu, 16 Jan 2020 08:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20200102181859.GC9282@ziepe.ca>
 <CAMGffE=h24jmi0RnYks_rur71qrXCxJnPB5+cCACR50hKF6QRA@mail.gmail.com>
 <d5be42e2-94d4-ad13-43ac-fcc1bb108ad0@acm.org> <CAMGffEntYmFfGD8BGEtykoFXD_3DvNWQ8hrRmDoLtdr9ykTwug@mail.gmail.com>
 <CAMGffEm=1ai=vkxLV7Qp0z3M-98BDej4mpc4WnsOpSHUJWuPeA@mail.gmail.com> <c0c05209-1f43-c242-96d6-1944e43d207c@acm.org>
In-Reply-To: <c0c05209-1f43-c242-96d6-1944e43d207c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 16 Jan 2020 17:46:19 +0100
Message-ID: <CAMGffEkXfwMU3AdNGhX9Z202UWJ-YhiCwaaQ=5NwfRmvyhOajg@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and
 the corresponding RNBD (former IBNBD) rdma network block device
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 5:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/7/20 2:56 AM, Jinpu Wang wrote:
> > On Mon, Jan 6, 2020 at 6:07 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >>
> >> On Fri, Jan 3, 2020 at 5:29 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >>>
> >>> On 1/3/20 4:39 AM, Jinpu Wang wrote:
> >>>> Performance results for the v5.5-rc1 kernel are here:
> >>>>     link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v5-v5.5-rc1
> >>>>
> >>>> Some workloads RNBD are faster, some workloads NVMeoF are faster.
> >>>
> >>> Thank you for having shared these graphs.
> >>>
> >>> Do the graphs in RNBD-SinglePath.pdf show that NVMeOF achieves similar
> >>> or higher IOPS, higher bandwidth and lower latency than RNBD for
> >>> workloads with a block size of 4 KB and also for mixed workloads with
> >>> less than 20 disks, whether or not invalidation is enabled for RNBD?
> >> Hi Bart,
> >>
> >> Yes, that's the result on one pair of Server with Connect X4 HCA, I
> >> did another test on another
> >> 2 servers with Connect X5 HCA, results are quite different, we will
> >> double-check the
> >> performance results also on old machines, will share new results later.
> >>
> > here are the results with ConnectX5 HCA MT4119 + Intel(R) Xeon(R) Gold
> > 6130 CPU @ 2.10GHz, sorry no graph for now,
> > will prepare the next round.
> >
> >   disks   4k nvme dual  4k nvme single    4k rnbd dual  4k rnbd single
> > 4k rnbd-inv dual  4k rnbd-inv single
> >     x1  251637.436256   254312.068793   270886.311369   260934.306569
> >    218632.336766       190800.519948
> >     x2  460894.610539   463925.907409   496318.068193   466374.862514
> >     418960.30397       372848.815118
> >     x3  603263.673633    605004.49955   675073.892611   614552.144786
> >    586223.077692       524221.977802
> >     x4  731648.935106   733174.482552   850245.575442   743062.493751
> >    744380.361964       656861.813819
> >     x5  827732.326767   827444.855514  1026939.306069   840515.548445
> >    897801.719828       762707.329267
> >     x6  876705.329467     873963.0037  1142399.960004    876974.70253
> >   1037773.522648       834073.892611
> >     x7  893808.719128   893268.073193  1239282.471753   892728.027197
> >   1135570.742926       871336.966303
> >     x8  906589.741026   905938.006199  1287178.964207   906189.381062
> >     1225040.9959       895292.070793
> >     x9   912048.09519   912400.259974  1386211.878812   913885.311469
> >   1302472.964884       910176.282372
> >    x10  915566.243376   915602.739726   1442959.70403   916288.871113
> >   1350296.325879        914966.40336
> >    x11  917116.188381   916905.809419  1418574.942506   916264.373563
> >   1370438.698083       915255.874413
> >    x12  915852.814719   917710.128987  1423534.546545   916348.386452
> >   1352357.364264       914966.656684
> >    x13   919042.69573   918819.536093  1429697.830217   917631.036896
> >   1378083.824558       916519.161677
> >    x14   920000.49995    920031.59684  1443317.268273   917562.843716
> >    1395023.56936       918935.706429
> >    x15  920160.883912   920367.363264  1445306.425863   918278.472153
> >   1440776.944611       916352.265921
> >    x16  920652.869426   920673.832617  1454705.229477   917902.948526
> >     1455708.2501       918198.001998
> >    x17  916892.310769   916883.623275  1491071.841948   918936.706329
> >   1436507.428457       917182.934132
> >    x18  917247.775222   917762.523748  1612129.058036   918546.835949
> >   1488716.583417       919521.095781
> >    x19  920084.791521   920349.930014   1615690.87821   915371.496958
> >    1406747.32954       918347.248577
> >    x20  922339.232154   922208.058388  1591415.958404   917922.631526
> >   1343806.744488       918903.393214
> >    x21  923141.771646   923297.040592  1581547.169811   919371.025795
> >   1342568.406347       919157.752944
> >    x22  923063.787243   924072.385523  1574972.846162   919173.713143
> >   1340318.639673       920577.995403
> >    x23  923549.490102   924643.471306  1573597.440256   918705.060385
> >   1333047.771337       917469.027431
> >    x24  925584.483103   925224.955009  1578143.485651    921744.15117
> >   1321494.708466       920001.498352
> >    x25  926165.366927   926842.031594  1579288.271173   921845.392764
> >   1319902.568202       920448.830702
> >    x26  926852.729454   927382.123575  1585351.318945    922669.59912
> >   1325670.791338       919137.796847
> >    x27  928196.260748   928093.981204  1581427.557244   921379.155436
> >   1325009.972078       919017.550858
> >    x28  929330.433913   929606.778644  1581726.527347   924325.834833
> >   1331721.074174       919557.761373
> >    x29  929885.522895   929876.924615  1578317.436513   922977.240966
> >    1333612.86783       921094.386736
> >    x30  930635.972805   930599.520144  1583537.946205   922746.107784
> >   1333446.651362       922821.171531
>
> Hi Jack,
>
> What does "dual" mean? What explains the big difference between the NVMe
> and RNBD results for the "dual" columns?
I just sent out v7 with also graphs,  it's here:
https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v7-v5.5-rc2

Measurements are performed in single path (-single) and
multipath(-dual) setting. For multipath measurement two different
policies have been tested:
- RNBD - min-inflight (choose path with minimum inflights)
- NVMEoF - numa iopolicy


>
> Thanks,
>
> Bart.
>
>
Thanks
