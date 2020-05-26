Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9441E1AD7
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 07:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgEZFza (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 01:55:30 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:6131
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgEZFza (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 01:55:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGHAWiF6lPLI96k2mx4rbvrqG4vjsyuxEE6JUAwCwSHibv0pofLdaZLV9rPRV0qATwykXOy1x47SlNtTn1ETWFpbtAoEO8d2NJjagyrWxrWqgGfY+O+JgTDQZcomIFfzlg4ljyOmXTlzJTBTQ/iKBCrdZrkHFmLFOh6kqFPC3ppTtqAO/cjYKM1t4UhhqbC3X/ZXrcoU4qd6oaIUJx9j6gCzgV+tq4uWBfwKZXIBQ0tdVVHqSCuXMVTNTq31gqw+2ICyuLbzfTyUD+cWlAeJgof0Ry2BKK+Ab4cGdwQwL20k/JZkH2vm4WvDjLyrXXvOjYD42b6mm1nXiYA6kR0sHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMKrfY98bY14Fp/5ckq8lyThvfQh0XXX5jVYZ7CsD8U=;
 b=f3byU57C3KcDAFFY04wdUxHsezmkiqNY+cqcK51DcyWM8tH0QDFnnnb5IkZMRMUJkoLvikeKYTObSfK0xXpmF3am1Zhyxuum7IOAjz1XpOrT5oJK9n/0/1vVwBzN/FZ3pQ739zVBg+w65OxZejQ8DQJKHWZZxO62uI+hVxYKr0Z9np3LrModVJ53bmGjy5NfypB0HEv2s+DtyfyHGJj+9UW/cl1KkjIOJliGjAD7qkxTM78y52EHmYhdN1J+biSqCjFn8Q6X9UpA0SbTUGtFRjAxiRCiKTqO0s3depc9pl2rrak+LF2V3/6U9q2Ex2JxoShyqDes3ajxSX4/PmODXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMKrfY98bY14Fp/5ckq8lyThvfQh0XXX5jVYZ7CsD8U=;
 b=jRooEnOhYjag5AMjKSE7J9Gp6ZBvotONY5NelzI5m7eUUhIv+Ve1qDM1vX4tajTJ4XfCc0MUGrhCMiWfYHJabZhDlVxCSubfmm41xI/UVFF/kwOgXzkRBjjv12mObCSscIRr1SGCkqfo9jrIAPSZbkFd/ZqtBiafAToT8pKVooM=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6614.eurprd05.prod.outlook.com (2603:10a6:20b:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 05:55:26 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 05:55:26 +0000
Date:   Tue, 26 May 2020 08:55:23 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: [PATCH v2 4/4] RDMA/srpt: Increase max_send_sge
Message-ID: <20200526055523.GQ10591@unreal>
References: <20200525172212.14413-1-bvanassche@acm.org>
 <20200525172212.14413-5-bvanassche@acm.org>
 <20200525175152.GI10591@unreal>
 <8633b4b8-fb7d-8034-e2ac-789ec61f4c67@acm.org>
 <0ca86214-372d-eefe-d259-d50d1e18f096@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ca86214-372d-eefe-d259-d50d1e18f096@acm.org>
X-ClientProxiedBy: AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36)
 To AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25 via Frontend Transport; Tue, 26 May 2020 05:55:25 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd21d17f-5fd6-4b67-8147-08d8013962f0
X-MS-TrafficTypeDiagnostic: AM6PR05MB6614:
X-Microsoft-Antispam-PRVS: <AM6PR05MB66149FCDE67B423A030E0775B0B00@AM6PR05MB6614.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDrDqFlSsBYrYIxrZEWXj11cZ7oRQ4uHROhX9Ai5amkQiLhfRWh0lGXebIoRZOk2iVikqItJvrgwDBtBFGHNqhHlVyg9wfw3zBaE/tClvZX4c5TL25KaaeI7CVUtjMnj+Wt7x191IzzkUixGFHapxr5J9PLcwXnOnEBSX0Fct9nhCw3b2+NC9ZIJCsRZOCfm/ZJGRhRUeVNnpOGSf4KWU8I+IRhDcpR60UMefV6os0IcFwUO4F9OxMmcWwbepFqQ3anSe/ZVc+FY6LwG40LeAn6qjroiDURp25NqDVt55jmN9KWtIhXxhbjmaWC2389P/5l3Ncr6GU1Fb6insOnKNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(136003)(396003)(346002)(366004)(376002)(52116002)(6486002)(5660300002)(66556008)(6496006)(316002)(66946007)(66476007)(54906003)(9686003)(8676002)(478600001)(86362001)(1076003)(16526019)(186003)(6916009)(33716001)(33656002)(53546011)(4326008)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Tr36yhDWIYZDxzLxW1SLsCR5B7uwOcwIwp9Yv+7CsMW6QssxQV//yg/HUOwu6bXy5pT7oUk6z3gl5BPm6F+JtkUt63XYEM5CXTnPlP+K2IZoCItFM8BGBp5NhucNMjdCnjNFmBGUuu3DjEPNDaOrQr54qgvoTPiuxxCdla1yiXodGDPfk9PVWzwtkHJlBNPlJtcKswWbSXQiA6Nvu0TW9glONTW5ntN/3iOFlOnygjhCgVvZU3n+1S4Z9ux1cKpLgwTPkX+ccDxdwRGtxNlLYl4X06nnipQWVdcXRJgM5VoqMde8+xbsUD/ChZorZibb4LEM0988CyyQHhL+1Uc9cC2AeZoRVUn3whBH3yod4J0vawYRBC77Iapo6rpFkmSXKQvFJv+BKzagZbMjSlJmjC30XJ8wXnMeiHtFvy+MPCuxBcGC+BISqwjC4s70w4+HW46Z6cDQGRmRuH7kB5DRyLNnL86Hd8LQ8x7jpAf66E38m6jK9DnyskZHBxhlhkktXgsPzRsGQEcghw++r3r8SQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd21d17f-5fd6-4b67-8147-08d8013962f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 05:55:26.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLl0MYPAeTxwv3HeDtynsCI1/xl/eTqhKH76Tae0R6yrsxZnSJ/XBNX8GVzkMnJzL/OcDvhmOWFtxGZ54HKQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6614
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 02:51:25PM -0700, Bart Van Assche wrote:
> On 2020-05-25 12:15, Bart Van Assche wrote:
> > On 2020-05-25 10:51, Leon Romanovsky wrote:
> >> On Mon, May 25, 2020 at 10:22:12AM -0700, Bart Van Assche wrote:
> >>> The ib_srpt driver limits max_send_sge to 16. Since that is a workaround
> >>> for an mlx4 bug that has been fixed, increase max_send_sge. For mlx4, do
> >>> not use the value advertised by the driver (32) since that causes QP's
> >>> to transition to the error status.
> >>
> >> How are you avoiding mlx4 bug in this patch?
> >> Isn't "attrs->max_send_sge" come from driver as is?
> >
> > Hi Leon,
> >
> > Development of this patch started considerable time ago - before the
> > ib_srpt driver was converted to the RDMA R/W API. Before that conversion
> > the ib_srpt driver was using attrs->max_send_sge limit for both RDMA
> > writes and RDMA reads, which is wrong. Hence the need for the
> > "max_sge_delta" parameter (max_send_sge = 32 and max_sge_rd = 30 for
> > mlx4). The following code from drivers/infiniband/core/rw.c selects the
> > proper limit:
> >
> >        u32 max_sge = dir == DMA_TO_DEVICE ? qp->max_write_sge :
> >                      qp->max_read_sge;
> >
> > The following code in drivers/infiniband/core/verbs.c sets these limits:
> >
> >         qp->max_write_sge = qp_init_attr->cap.max_send_sge;
> >         qp->max_read_sge = min_t(u32, qp_init_attr->cap.max_send_sge,
> >                                  device->attrs.max_sge_rd);
>
> The commit message should be shortened to the following: "The ib_srpt
> driver limits max_send_sge to 16. Since that is a workaround
> for an mlx4 bug that has been fixed, increase max_send_sge. See also
> commit f95ccffc715b ("IB/mlx4: Use 4K pages for kernel QP's WQE buffer")."

Yes, please. The proposed commit message describes better the change.

Thanks

>
> Bart.
