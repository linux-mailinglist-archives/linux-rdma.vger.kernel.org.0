Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806B018D0BB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 15:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCTO14 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 10:27:56 -0400
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:27099
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbgCTO14 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 10:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGHUcT8nJS0RCkeol+l6peyiLECDS8Vf7woCs9+kB3A6ivaX59cpk9XtktpFbeTqxlRMnrW8aAn5r2cxtfk3qR6+8zoAS7qKYK3ZXYQuh75MV8Jz22z3TyR9DFG5RRXxbPrsb6BY86PGRvRTEULtrzuDtnELp1y+tXq6NfwJvhw8xugItlIJppzMsXLARutmNx6BPciAm56zMALTcxPSc0Z9wO5NvgCRRa5vbQ2gUYx+KEeO5DYC5/JJLkipk1LlUZhlCNoZbBHviVCBR5byqwjxdlhC6OzmQYYhuMTR14+Yr6bmN9EHg249llJedbpcUHVIJC67kbSjSaQ4nCcSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFFHkQtJYW9bs8afAh3vXLmxD/2w7SWGt315wVxhBoU=;
 b=Q7iORRLM1xulY084/u6+i9AjCIGpJVYtTEY1x+qlD3ouIpbrjwI0MxXCRAL7Ia9wfRdIgOMWDFTu+h6ubLxqtqJIcnhO3xGa5EG6jpx2EhAbEbY8eHPKL8Kvht2ky2prqYfCP1Sfl685E4NV0+6AnTCZJdaisag5U2rMjlTIsXqSPjMaQ0MrGkBPYqEw9y9vN2taWwPnSMsdIZ+iLGfqiLsM/na0fNs0QXGht70OIAWL+1XDeJ4L8jcXAUsawb4qGg2MXzoMlRAy+OVLn7sVzKlCfCGhkEyNFvaL7iJ2s3EUvVTvUx5cpWaMn8oArHHK9VN+a3eDKmgwpgKun2PMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFFHkQtJYW9bs8afAh3vXLmxD/2w7SWGt315wVxhBoU=;
 b=Wbmfi3800xjR8a5NYFxS+YG7RNQy1mkBnZXsWSyVtBKFmW0cYvkBXqW2Fw1ZnJ98baeXod+LTmtBhYvB4oP45zGOZbb9bTYGqm6LmY81QCveIY/ddWI6+94QubP+bJ1oMaQtlVPh1bHacHcc+Z48/G56Ti69ICjnsC4m0atlhFc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB4455.eurprd05.prod.outlook.com (52.135.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 20 Mar 2020 14:27:52 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 14:27:52 +0000
Date:   Fri, 20 Mar 2020 16:27:50 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com
Subject: Re: [PATCH v2 1/5] IB/core: add a simple SRQ pool per PD
Message-ID: <20200320142750.GE514123@unreal>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-2-maxg@mellanox.com>
 <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
X-ClientProxiedBy: PR2P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::18)
 To AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by PR2P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Fri, 20 Mar 2020 14:27:52 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1ffbea5-bd36-4fcc-01ee-08d7ccdadfd1
X-MS-TrafficTypeDiagnostic: AM6PR05MB4455:|AM6PR05MB4455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB44554DE7C04691B226A51987B0F50@AM6PR05MB4455.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(86362001)(8676002)(6486002)(1076003)(33716001)(66556008)(33656002)(9686003)(66946007)(66476007)(186003)(6496006)(8936002)(2906002)(52116002)(6916009)(478600001)(316002)(16526019)(81166006)(5660300002)(4326008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4455;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7W9wnCs8+B81/JPPVU4kluFw4X9ScZyfp7x2Rc+iair8QXHpeVj4t+wcUsnB//R6CmXJHqELctYp7d6gD9QRYWlWiV4l8xlvEsU6QS8xGUktvc1Dq9wjs9WMPVPyzYe+WnOvU+BV+KNFWi/8qbZ++iHS2g62ex7vxovMCJdLoQPFIchiROGtMpZVRL9HHm+sN2lWqzweHw67VNRYcZ7AOvoMwC9R8MIc7FOr3WliiJsM0klmCK4sG4aQsne+SkO3VwnNnoMyITyQr9cigYHNgdf/0jExVlcfD15shk2Wvi7Ca+yWQH9fIWwJl/snCbZv0rcxxws8c6eQZ57BB6oqb1tofOv9o8M2qm8rLUf+pD2mXSRyyJtlSdRTjff/9wXq092n5tsFPvRjWlpYwC6FFkqO9K4u2DnHV7vRK3E++LkfjuOQbFfAGRvRYLZ5uGmi
X-MS-Exchange-AntiSpam-MessageData: HhBISl9+Vw5Ix5ex97WzMydevC4pnNKAqab8RLBrnztJWMDjuQtZZ/0P1h8N2RguzcFvrVHkOqifuUhkmuIzAXDXHusPRaPTeDbGl2ruK8YP7F+vfUTgr+Cg4PLrcxU7iWPtzDc+4Yt/GlJ/zLoQpwvYD+Hd7r9IysBeOK9YGYc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ffbea5-bd36-4fcc-01ee-08d7ccdadfd1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:27:52.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIbAIt0qDOb5Sv8CAWqm2vKZD34q5kOVmxNKaFYtWtmSS2HGXNrG5jIJnGGne/zmHivFN5DmEBmJRSw/dKREXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4455
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 10:59:33PM -0700, Sagi Grimberg wrote:
>
> > ULP's can use this API to create/destroy SRQ's with the same
> > characteristics for implementing a logic that aimed to save resources
> > without significant performance penalty (e.g. create SRQ per completion
> > vector and use shared receive buffers for multiple controllers of the
> > ULP).
>
> There is almost no logic in here. Is there a real point in having
> in the way it is?
>
> What is the point of creating a pool, getting all the srqs, manage
> in the ulp (in an array), putting back, and destroy as a pool?
>
> I'd expect to have a refcount for each qp referencing a srq from the
> pool, and also that the pool would manage the srqs themselves.
>
> srqs are long lived resources, unlike mrs which are taken and restored
> to the pool on a per I/O basis...
>
> Its not that I hate it or something, just not clear to me how useful it
> is to have in this form...

Sagi,

Why do we need such complexity of referencing to the QPs?
This SRQ pool is intended for the kernel users whom we trust and we don't expect
that QP will be destroyed before SRQ.

Thanks
