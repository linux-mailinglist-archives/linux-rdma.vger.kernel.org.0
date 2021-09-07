Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7754027C5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 13:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhIGLco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 07:32:44 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:5058
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242785AbhIGLco (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Sep 2021 07:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWy4Fcu+NWGpfd9bkVxVejGc+5QxTI0WjI7Kivw1DrcKbeROmWWA9ELZuCdQYgfg/huEbBRyDP7LfdJmfAT1Py8qW+QamWESDaPea5GJAud0eguh9M1CL+E7KwuK17BNKO70PsZac4Omm6y7mcKkjohr5myrruTJTKpBJgnU21A76bux0nE96UOfLfUKXuoTEr/0vjk7TgiIOzNgld85bO7uFqYNnk/qWC4/VnNa8I0yhHdNZrkT5hMoeMAZOPd+Cq+NXMVsTtbPn1Kq6D8yo9XHO4rM5N5RzJG/e4gEbM/TdNDzsmD/yWKo5DXqm9T9LkvPAREKH7ZIa45bXTg/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m8Fu1i+miVCOjpE8S8pXDHKfVXIhdqVDoEqKk2Ipr7k=;
 b=H+LNg27O65vquY/7MRa3QVGSkHpWVZ7zB2o6BQ7EhZalfwJ99Cuh3tSkDy299q+2rv0jpV5FeRkPRlpnoSsLvi2HXFjmHaIc9JH4Quj+t5NhNPHS5hh1b8mcgZD1IZiAHTu4qbRNeNTa0nRYW/jsli2V6UNdDCzVlqz8Kj6H8D+iDiucZ8YH4ArhA0v8YcEa5AXmaHnOogeBjbcY5GmChzUNDKnSRTZQfBIZ64/8fETmFUIztH7vuDYpxTI2eZIsbNfdFpGzigM3ixHHjhPV8i4TFdF3+fpb19JmIJC+Bl4e4SCn03Ocr/mK2Ngr2bz0ognaBhT8815jP8eoHZ5enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8Fu1i+miVCOjpE8S8pXDHKfVXIhdqVDoEqKk2Ipr7k=;
 b=P5ujOAiZDHU0FL1+IpOjqp+4nfu3NKIv/FGMI/eT688pQWo4B6y0OLDXHAs5/rczX6vFfZ16KP+QdAyej85/pE3ua4LfaZ8p6eIYO2AiPp8Kr4F8nxJ+YSUzTBr7/y0Hc8dbcVNZFuecRCDU5zVQCP0n6Hl/Pj/ZzoOQfcsJ90xO7UmgfrYU2WaG27a9/U26uu2EsTOK/20SEXdA1yxerQQ1LS0YrHDKgrcZzI6Yqh5rSiEB5tnBMqb/Uh18fHIewOAlRDMDQwILrpzGeWaucy4AKdMdSYFxUnnnmbhPaGduSddVRVOJJv4eJFj/Oa0j/9NDwCeLQJ8u7MHjUHFXMQ==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 11:31:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 11:31:36 +0000
Date:   Tue, 7 Sep 2021 08:31:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210907113135.GE2505917@nvidia.com>
References: <20210902151029.GV1721383@nvidia.com>
 <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
 <20210902154124.GX1721383@nvidia.com>
 <9ffde1c4-d748-0091-0d7d-b2e2eb63aa51@amazon.com>
 <YTR4yhTyYi323lqe@unreal>
 <dc14a576-c696-bba7-f7a4-1fc00ff3d293@amazon.com>
 <YTSh+wU572k00WVS@unreal>
 <2231dfa4-2f99-5187-fa83-56052dad9979@amazon.com>
 <YTTCycq4KTBk6r/s@unreal>
 <ed19464f-d046-bc10-ec17-180f7c54ef13@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed19464f-d046-bc10-ec17-180f7c54ef13@amazon.com>
X-ClientProxiedBy: BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Tue, 7 Sep 2021 11:31:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mNZKB-00CDH6-0a; Tue, 07 Sep 2021 08:31:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef3ceac5-8417-4c14-8456-08d971f30cf4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157E5B25E52D636EFF3EF78C2D39@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViV4gZSdOfNxxDa+LtaZ9Ybv5VcRyiQzeNIHu+8ylJT1ZBbOENllVuvNPyALx/UkG6pmYKrMummhfOAdzFgYfkQ2L3Ixy7hXaqK/Ibycz/VsVJxpW3Ju4owTQesn1WSL2SBKyS5WIs+Z/CBlWJCZmSJ0woZBGB5/MvgDecH2YU8UIYrUPBhC/EW8VQ9KXfDBy2c3JHh4ByShFJzfaT1sBRsit3aREcYImsvtha36DMC3eT1OO4AfEZO9Q4/rn/y7MH8dqjVyQt7o7CZaw1C4e5lN8GbT0pgS9lpdk3Onx4Ztwd/dAWBLsjcilngT2pXYYxwxktpU75rfMICZcCIL1p9BeOfU2Rw3HdvxrC5YDVRKMekX2cATpC2wY42nzSDRKSfjwvUJ0KzuhE7lX6sfYI/ZKUVhHT3oOBb0OLWg0c8YwardlGuevcA/f7Bf8rPgxAU/2DwJYk8EtnJKnWwqSvxJdGXxHZj2GLztXugj6ngC6eACZC6ydklw+pfCfHNJIwKCZlHydhiADxX1upyv9XZDnWodcMYL0V0ZBjFfEUlCPstwkpynL5TiJVq/5GFcq7gMfDmKTfL/5v68iPs6KLEIm0GIQrG9kmbt5huSFdqepKqfDG0oxoX282n5v6OZmV2oEWy9oc23ODpOCNOsIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(38100700002)(4326008)(33656002)(36756003)(426003)(4744005)(1076003)(2906002)(66946007)(86362001)(83380400001)(2616005)(54906003)(5660300002)(316002)(26005)(478600001)(6916009)(8936002)(8676002)(66476007)(9786002)(9746002)(186003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzxnhPIJ3yjxxjQJ7aoHQb3UcQn+6ZlMD6whLZ3815LAw0sGEJIISQ7AjKOM?=
 =?us-ascii?Q?3G5C7CBQpzxp12EVix6bGx7l5jq8Wl0CYNMlnRpDo9xqUAxYUJi4W+v+OGXT?=
 =?us-ascii?Q?v/AQkWOc1Oay6InLI0QRdkOrAm2IbahuOf9S1W3SOM3PABqEH7f005WG1n9U?=
 =?us-ascii?Q?R0PQvtXrxUj1JTjyxLbNPKaqs2e/dCxXkgw035Ma9gFUEjzU3af4kR06MncT?=
 =?us-ascii?Q?+jZyf2rWgj72UH99g9scnD7P/KJaZT98yV7XDCg/keaP6bzFum9X/PZ9TlFk?=
 =?us-ascii?Q?3zyzdb8F/apuHamLZRu8etG8UnJJoDeMvnbvn5NYNIthMVu1OoKz8p3fZBXs?=
 =?us-ascii?Q?lw+p7OFTFayH/zXptYyD4/daV3puKyre6i8cuhXssUcUVTBUgfZVkpG2sfEA?=
 =?us-ascii?Q?c9U9cTTRRoIPSad+lOvn0Z3aDhUBNqZiw+Xpzjb87lrtoS3xdMLyn8RkFxUe?=
 =?us-ascii?Q?Y4ZKE6yMObYg0xfmekBWzr+XAKbLV7Ny7ogWJCQk0xMqqW/TgQv+6YJQWcvl?=
 =?us-ascii?Q?lyTazaHdLGIuAEi7XmScsOkVOF77h9Bs62x3FZz0Yv7XjZc/tFXceoU7xWgj?=
 =?us-ascii?Q?dmtDYVZdpOHLfWNOQaLKQYpJCcxZAls3VisyIVgbsyNOgS8ayiE6fk0+bjfV?=
 =?us-ascii?Q?SDTbI+pkepw3lKh/xGGAtmNuRrXfWN74UQjqRCx3BeVu2Horb1K1hnmXKdmG?=
 =?us-ascii?Q?OPJe+rLwEjtQLQmW03W3oDmwwSKBuq7w8O37nUMgiFTuW5SXzZTDoiET535g?=
 =?us-ascii?Q?vRJ1vCJooJD9zzwxb5vhslZdiVihQM6C0UF5uUn/YFJ1lA4LCN2OwowH17Qi?=
 =?us-ascii?Q?83ldfSZfecPBdo0e2I7IJMgqySf8HPC/t74CkdzPs3wvaZVW5XJzi9s+M27y?=
 =?us-ascii?Q?pRqppzCjmBky5ctHtLf5QGQe4fyvjoMzTmM2pW/MttKqXJ3mlUC15u7xdp2C?=
 =?us-ascii?Q?8io2eXHaQRG99+6L74SkKNSINWbWaLDUFO9cnbtLpkgyGGssjxtXUiyn1wpV?=
 =?us-ascii?Q?cXFXrPaf7LEbVkHZJ9HakGGjC3x4L0XsXQfo+CP0MoEco9OM46uxmmFHED78?=
 =?us-ascii?Q?mMlp/NU/53wiehziS3luv8aOLcxbowYNZKPEzbgdzOWBFa+qAowZhyaF+Q7+?=
 =?us-ascii?Q?4P1cq0fqQhoJ97exPPhi0i9ODonuu/5DeCJr841GfpigMkjZ8UX02A5r9Y4Z?=
 =?us-ascii?Q?5sQ47oeJWbcPhChJQVN9qiUF9Hmezdf0wk3BRCHKrgpQfLw+t9X9+6NzyOTv?=
 =?us-ascii?Q?4LGbyhFVdnSERwZ9MEec67gLbqSOcO/F7uqAAQVXHMrUkETp/r5Oo+H/yH1y?=
 =?us-ascii?Q?+TIrMN6nQoMT4JALibxbvBL1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3ceac5-8417-4c14-8456-08d971f30cf4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 11:31:36.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Puh0zsDLbDw/3ft6H2o5kHoll2N/EV5RaTizaebiElMvnyQFHzA9iIKBTpSXDJCl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 05, 2021 at 05:36:23PM +0300, Gal Pressman wrote:

> > I can't say if it is needed or not, just wanted to understand why you need
> > complexity in destroy_cq path.
> 
> Well, as I said, I don't think the restrack protection is enough in this case as
> it isn't aware of the concurrent eq flow.
> 
> I guess I can put a synchronize_irq() on destroy_cq flow to get rid of the race.

That is a better choice that synchronize_rcu(), IIRC

synchronize_rcu should be avoided compared to all other forms of
synchronization because it can take seconds per call to complete, and
in a reasonable verbs app this means potentially minutes to close the
verbs FD and destroy many CQs.

Jason
