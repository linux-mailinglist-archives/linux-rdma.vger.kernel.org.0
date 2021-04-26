Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB236B465
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhDZN4q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 09:56:46 -0400
Received: from mail-bn8nam08on2089.outbound.protection.outlook.com ([40.107.100.89]:62401
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233682AbhDZN4p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndu70zLZW3ZZSxhsdxG2nBCHjHgTEWilfy5p0YyQKp9iApR4H9cpcErBy/lTHDoTlHcEh+ka9lRY7XT7KITiO9OWzCwCv8D3V0tXqifo20BSCdnH/Si/9Se7gVoFnCL5cY+apaHCcz4u4qNKXjT5Si2ACpc3gJiQ4kmqlKcrJEgGB0btLXGf28V494964XZ09dqTu8gdbESH3VqIuTgslFZdhZ4qMEWFbzbyec7jE7XLibEL3DyeRvHfEH6mVBpgMbfikrSaY4pV9tfx2shPP5GiXuwdglyP57USCtEtE5cXzt5gx6HYNOEOSBYW5pFlBcyEA6IT/k64TDQC0PoEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWXd9aJo6Zn8cbIs5dhe3Qw/fLL4rE3uptiBJr/Sb08=;
 b=ey+uvXRULcSdS2AC7Op25pZVfb6EsSFWXoiim3IbNcwKALmVtiIidSdIr2a43mbDH0+cudtq4uaEp5wrBl5ksf4VvtiOQvfgPfO1QU9JzamNOsPu53SRLbGcazxYdpTa9EgF8IFfrDHf2JYUhuIEQeSfHtqrYLSnToL+mYinU43ktpAH7K/AHBwaa/bxnaQsKs2PxafLH5AbeM/Qm2mUfzLUv0L+sPPlRoS6xYKODuLzXvU++huQMLDukDsHjM3WpAv+FRuZRaL5DO7ykbVbLc0Wf/2HReAg3i9SoUrqfWtJ6xtEhxbI+KUD6lQHcVLE/WfrdtqK0oyRkxXB3FlIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWXd9aJo6Zn8cbIs5dhe3Qw/fLL4rE3uptiBJr/Sb08=;
 b=pOYe6rTZNBRYgamNe2wu0hUYExaAjpiSS1/whqh+ZIIInK/a1NVmfkPn/lyJeJxF8DW4FnD+Mx+xE8mduZhBSsiBmIIUFbP1H5tlTnQlttX72/4eJ5hJXqbKrGSoP20ioeRWFmAZOgCDRgLD+mT22F+ywVG5xoJjoO/su3oIDHdHmas7y3Ctm2Lt1FrcoNg54XqFynwHdfyuaqpAvVEfNh1KPo541wsVMRsi/4zGgN8x5z1+hW/O3JLqwoJPHhkVyDl2fUN6Z0INMf8tZfng4F7Pah7w+p+MllZHIHkygJLNvxOlI4qA7arNfdsfG38IONF1V533t99gHDbG46Umdg==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Mon, 26 Apr 2021 13:56:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 13:56:03 +0000
Date:   Mon, 26 Apr 2021 10:56:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports
 when remove a cm device
Message-ID: <20210426135601.GT1370958@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
 <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
 <20210422193417.GA2435405@nvidia.com>
 <2eee42c7-04aa-eea1-f8a1-debf700ad0b0@nvidia.com>
 <20210423142430.GI1370958@nvidia.com>
 <b14de504-52f8-14ac-f65c-bcdcd0eb1784@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14de504-52f8-14ac-f65c-bcdcd0eb1784@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Mon, 26 Apr 2021 13:56:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lb1iT-00D3yC-IF; Mon, 26 Apr 2021 10:56:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8e234e-8ed3-4878-622f-08d908bb0775
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16583027E0D11884AE3BDDCEC2429@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXfrOWgaABH2MWM6nE7Q5uLptx8OqWtnuH5b0f4EzPIpUFd2YTRTThnzSuWQbFMXcq2PEHR1/ItLDJZXiQe+WbnPfF/QhIFu1otrXs8C/T+aLBlDIa05AkBkB04SXulK4+vqwokf6N17hrxdEF2b78p6kmKe7ta1zg+Q2+2LyIvQAkT9AEw833ATCU7kgr1/gmqJ+i1ukhEU0AKW0dpdkMs9xL0VEY2hFSND+ZgvFh7lL806o8CQpSB6B85NJUnkT40yD7iYjU03dK5hTst6n323aOXgWxWyzP0LdsIB/cjlgUvtjyWpgxgWng34PLQTDET7jDmCyBb6g94chgyxEJAUg3UoSxjU7SFCCHD1MzCUTP1cBMy8LAZuq0cjYKBJ3VY/9MlsRD6qJcO4bIVdOvGIlsAoFycLblvGVxH62RjSjeeipQ07KulVB+Wm91OYkicmhBv9w4tLxJ69r2jvQV7kgkPt11MlhZTpnpUWZB5SmcK4ymNVLjbbgJNwswEaMsFAaS6cs60rS4hQiixOeVuA+eFimMBN/UZjrelvcChQI3OcZKqY3QsZFRXPOw4lAVL0B0EuBo0EdgrkQ6Xdd5HI6yNIs7cXPib3Tr+vEC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(83380400001)(66476007)(37006003)(4326008)(186003)(54906003)(33656002)(8676002)(478600001)(6862004)(9746002)(9786002)(36756003)(86362001)(26005)(2616005)(2906002)(8936002)(38100700002)(1076003)(5660300002)(426003)(316002)(6636002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iyX2cQNqr9gtAR4wPzcR9ZGHahHsDz865DnG34VE9j1Bj3UVQ+LTzOIJYoYD?=
 =?us-ascii?Q?mrIk589vlaVWxXrJ7efWrHKeFEV81SEZM9FhdzyE3zBs/ceBNhRxl4hzyA5x?=
 =?us-ascii?Q?vX70HyldF+jEGwrP2rmNvZJqKEQ/ouN71sQWqWSPwLYGDUdpi8f+32jNV9KN?=
 =?us-ascii?Q?crAIhUhW6WSUKbUJqL7hcWbb4HLR55AhhTQOVyru3cBafDCt5E1gfA/v9R5f?=
 =?us-ascii?Q?FmAW7zP8V9G2eFd1MmtoUyCTzNtxKO2Nft6/16K+cqng6ns8quhwc/qmZdIL?=
 =?us-ascii?Q?3Rtkp9imkRR7Nxh/9/TOha7evzaypy/1pq3umO6sDBsr+8VSEtFBt0rBSkgB?=
 =?us-ascii?Q?D6SA+NnHzWf2D4ncbSxe73OskyMplbw6sd5HnszSQ2xqkm3TWwkLgb6epYZX?=
 =?us-ascii?Q?/GsAhFedb3qXp4Herl16nC14GYm35l2aseqBKfhLtwWJ1ySPo32Mkng5UXML?=
 =?us-ascii?Q?T2iEDzo4ek7FyDv1ee1CqlslmAvqpX28/+cZSXbOIVaGSLFesf9c4MoZT//w?=
 =?us-ascii?Q?ZMNeZZ5aWS3mLlMHO56bnUiHUiHqCZtiHCpCNVJsfF2a+dYzdSfU2D9Ef11l?=
 =?us-ascii?Q?+kLonE7YkcD3elFWCTwvIEyjXFDPxBRNtQA4w6WMka8NcpprOEa9ZkZylGQT?=
 =?us-ascii?Q?3YoX2EoKKOSs8Zx9/nW2ihnmC16IzJoc2pC4FbULBejaxbCIXbHL4XMnZyTj?=
 =?us-ascii?Q?+gjduHE6//3+fKC85D/+RNPLWvoA16QhqXAgbIJ9CCG119Ti9oFSiFc6/kuh?=
 =?us-ascii?Q?0gfIeXPbVGiYEKwfyz5KtlkFYZBQYpmvchT3iOK7wuuG/KvbZFYjiuFWYJOp?=
 =?us-ascii?Q?wTPh8JWFfE2/1Z5wiiLNjBRMStJiGUjaAacVh2giLCo8nYBWEwNANsJ3MQda?=
 =?us-ascii?Q?BTqtPLZKlv+GM91+/2pmD1WohzjTw4iQPDzdNPB0bIW1QTgUCMgSd5FsUQpz?=
 =?us-ascii?Q?Xs+6h0HGZQ63n4t9RkrPWeCxycEqyx9qK1UXYRnjfsi8WjMp20Ictiu5khpI?=
 =?us-ascii?Q?z7VTnw14UtIvFj1CI/nUfKgBK5Ll8I/YPMcPe1DyL28j/+xVQ1tph5Rk2fS5?=
 =?us-ascii?Q?Qf1jRFNutY3z6D+ZnVEU/ZYX4e3iDN2ihG53WiR+upA0SKz2kmJOR01K9vE9?=
 =?us-ascii?Q?E99+V8Jz9Cd6xDua4yjU66n+AULBAiWX6nuN9qjW+vuQiM/7LVDYhP7IsfFS?=
 =?us-ascii?Q?5xrI4dSU1vVw6Izx5JFoUo8PMkEF3CN7VWsY7bcN7YuKSLRnCjBJgdn2lfxW?=
 =?us-ascii?Q?RjcKUZViS/O6jb6R3NHV9vnjrAbZ8MnQtSWePZPZY5HAAY4bwwF6WvflDrfq?=
 =?us-ascii?Q?3klqcPVc5G3qfJ9f3NXk31J2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8e234e-8ed3-4878-622f-08d908bb0775
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 13:56:03.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKPYlyJTvIlK0s3pC+GNok8G8DI4x+aNH6U0tlQ76dyADSKeXxOMEgK5Jol/8N5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 24, 2021 at 10:33:13AM +0800, Mark Zhang wrote:
> > 
> > Set reverse call chains:
> > 
> > cm_init_av_for_lap()
> >   cm_lap_handler(work) (ok)
> > 
> > cm_init_av_for_response()
> >   cm_req_handler(work) (OK, cm_id_priv is on stack)
> >   cm_sidr_req_handler(work) (OK, cm_id_priv is on stack)
> > 
> > cm_init_av_by_path()
> >   cm_req_handler(work) (OK, cm_id_priv is on stack)
> >   cm_lap_handler(work) (OK)
> >   ib_send_cm_req() (not locked)
> >     cma_connect_ib()
> >      rdma_connect_locked()
> >       [..]
> >     ipoib_cm_send_req()
> >     srp_send_req()
> >       srp_connect_ch()
> >        [..]
> >   ib_send_cm_sidr_req() (not locked)
> >    cma_resolve_ib_udp()
> >     rdma_connect_locked()
> > 
> 
> Both cm_init_av_for_lap() 

Well, it is wrong today, look at cm_lap_handler():

	spin_lock_irq(&cm_id_priv->lock);
	[..]
	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
				 work->mad_recv_wc->recv_buf.grh,
				 &cm_id_priv->av);
	[..]
	cm_queue_work_unlock(cm_id_priv, work);

These need to be restructured, the sleeping calls to extract the
new_ah_attr have to be done before we go into the spinlock.

That is probably the general solution to all the cases, do some work
before the lock and then copy from the stack to the memory under the
spinlock.

Jason
