Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68CD3428BB
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCSWer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 18:34:47 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:62016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230285AbhCSWeV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 18:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn8gMNp4YSr25bX6/c/auqvYvso7JsEflhKH73TobUdPhF55IFStEN+qwvGCpiHJhxLAPO/gUI6KDz85MTFr5Y/zsM7nJetId+ENT/CUMZf/5Ko9JibqWG4AJOOVIWEz7E6OInUPNB8AFfPieBkcD7IoBSfJ+sCFpA4emHezqVvGf3Iy3le8CavYun1CfXnw4o/GKhGKXcaLs4dQx3Gwni3NHYNo1N9DgMxKQdjUfq3bUHiybIMUfpEtwSoC+KEAI9w5Hg+S1XpJSb+0pF/B7P6KeTP8YK5wHQ7UAaSUJKrsjmJs9Ip+svar6/oYEhqxDO+L9LmNwoMeZX9xoXWtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffjq2/QWBBWe6ygRtd4eXxepXU+dkAhW1ujSYRjqipk=;
 b=IHGzYHKxSvgUq3yPnFNE4z65GixxU2WNw2P3tNW8tkYZE21S0NZ87A1vFDMTF4BP8YbSbCsc5Sge5kQF+ur9JPrsRuVSNVgwcTdK+h0OlutELFwoIbqxjWMEjZuz0HDJjOtnUhkWe7ImUEBTNRSneXToDo7lonVPjmuxVOuxwc2ffLU3ysIdonlgzawMPy/eLTh6tOiqgwizJ6sbktUcpAJMAFWe2gcykgCTHUGrRtqhwDPRrNO8fQHgmaIKDAxaR3TpafUFG2C0M7DzE8oPEdtK5bfCXnA9Caw8xkNZFSPEQ3IrgphhPpZRCs3c4cSyV8afEqqifCE0nKBmDJKGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffjq2/QWBBWe6ygRtd4eXxepXU+dkAhW1ujSYRjqipk=;
 b=ovJmX4nGSUSos7IoxPpuZ11zHu8UKIUJ2xCEf9rrv9vZkBW+mKO3Pg5nX7HCzNgrgH3PwM3u+kcAv+Q70l3bJM1RwGGrVT9FtiTO+TqYRt//eL6eRTUv+xG0yo6XzFCqvrGE9k6SG2TFvOtJePU5/A9rUGnyTHn1+x1iFV/5MVceFoEOgjm8Y7VK136NRYO7sCQcyVxFVtzj9BYQhQWjmbeIzMOb9cmYnoOowORWd4/JM6Soc5nEPurlbkTJWOyt7iaZFobm3BKptsukLHnYP+QQ3p02tynzWJZSjyitaYi0ifoFQYUqID6dq0ExYTCol5tQVhp8H/B1m7mZA0a/QA==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 22:34:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 22:34:20 +0000
Date:   Fri, 19 Mar 2021 19:34:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/cxgb4: Fix adapter LE hash errors while
 destroying ipv6 listening server
Message-ID: <20210319223418.GF2356281@nvidia.com>
References: <20210319194721.3597-1-bharat@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319194721.3597-1-bharat@chelsio.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0442.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.14 via Frontend Transport; Fri, 19 Mar 2021 22:34:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNNhC-00HUCI-SW; Fri, 19 Mar 2021 19:34:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad3e28e-3057-41d1-78d7-08d8eb272338
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426559BA4981E2A933A3172FC2689@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbjRSTTEtqaJ0hUN4so+zOVUrbVkp26axeO5gJGQsYpxqi9wjnqSx0LqUKRSamNH0aMf82BOaAf//J7JBTQcrE29CfZxzm0aabIoSFjECK6GWW2ukMKbRbOcMARLB0j7/9lPcRABSdMX3LAziTvHrzRWkUuNupP8pMPbZhqIDVSS0lM4gLvk1V3EIrzb4Eg0DBgMShFbNB0dO9GQ64APHv/f9y/lObFUstaCBCIvz3MMWlcVGRzyxd9VJ7C9lgPL7969flfa7930vT/MvR/PY/Y6Q941g3uI48BMd44LoPirFcUF8hycP9B4/FAGo1ozprwf6CcmMGQ9K7wljOeRZEguLoIkJM1XZWp8+aDrus8duZCZ7F4+uIAiKN/nkamx0sc3hDCpt2xEuAO6CNoyruzGq9ewgepPlWuevf5lGIOv1PEKjIH02p3xZuNYfkoAgxiPhme07yAE++4ZUUhe/ssXWTwfEYrm/W51PgxseSwYhBeiWdCblJZDKEN7LgswDy0ntr4iheNYxGmwiiWMtKuLr3KCSzazjrwMT2bW4ivrr0d8ycbtNihrS9mPvxyJ2Rm8E/roVcDTyCe22Ei6FOJgIW4AtXGEfJb2DYOigXRAp4inFWp+/OW/QViosUzD2QgqUT74a+FeYfBaveQhoNgg6O41vZMdsdms/B3RHZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(38100700001)(4326008)(2906002)(86362001)(2616005)(478600001)(9746002)(9786002)(8936002)(66946007)(558084003)(8676002)(186003)(1076003)(66556008)(33656002)(66476007)(316002)(5660300002)(426003)(26005)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?URd65iUEVGZBEf4cjymbLXYgOrNNeoP8X3E3MJxazig3+1sy2so0UBO3jdPV?=
 =?us-ascii?Q?XFh3UGvW9YKnCfQrBVyDugsJvj35uIPdLJW2jztod5UlN4sxoWAd6TN524Nn?=
 =?us-ascii?Q?HHV1HaYO203lHEIDDMohCmlv7or1aGfcsa/KwLH3B9SI9FERQKTnQLYyYFz3?=
 =?us-ascii?Q?8+Auqro9zNpIL+YbuXsdfVY2n1BFmgXlgeGFZRfeC3Po9MgR4eBQ3PN+LDL2?=
 =?us-ascii?Q?ceg4y2XCU2hkUM7DUHV9QLBItoTkH0asWT4ja7x2ThsGAgnS45h2k7GvmfJN?=
 =?us-ascii?Q?BraZX1/rObg/BNzuNWO6vXjjs6YZVL5b9mDGpLpicAlgsT9wRqkO3WGgNBT6?=
 =?us-ascii?Q?StPdZCAYcbzf1TtZNOwoNMoxUIYL9GCcpWVvKJD1U6u4J5V7VM/uTLdcJtP7?=
 =?us-ascii?Q?TCWZwDGgGIoGZIzyjdpyUyoVt2gMl1ViZvmAlFfoZ3C+J8RPSm78L6qSw2EA?=
 =?us-ascii?Q?Nvtv8TEvZXmIkc7gJg4naknHB0+xnh+lF5FpRirPJna5dScU2CgMKc82t4aJ?=
 =?us-ascii?Q?dxSFU65zlN435ZoSXBz6jtRu8yjXzXg8Yvk1HhwQT9OtPKqiUgrkmOIEZQyW?=
 =?us-ascii?Q?36Qzmd4ya+dzbzU0yQotZA2RdC9kmMaq19/1wvef0iUvIvaz8sWXpc7i7tmW?=
 =?us-ascii?Q?WVVyiMvmpAQs5BJXi+EofHb/MavmVlyIogHffOiQIFLeXgIglLi7KfD3NETV?=
 =?us-ascii?Q?NaXz8vsvTDUYHYUuC45zjYXzc2CQH6H7KU+NHY5Miy5khyHYb7usifzIANjG?=
 =?us-ascii?Q?GrzdhLPdJZ5IDgtSSfWYkWlNyt03I3REwjE3fgQmCvEGQ3IFRpTEGbykYRNF?=
 =?us-ascii?Q?LOjn/ASUDwU0Ryd6j6q6vttW7jwtZA99lSJhUb3M/Yi+gB2nCvgN9Mon1Hup?=
 =?us-ascii?Q?Rh5ithcL2TgzoHek2EtaLA/n+S4VM6e1HN2IPn+JlBCG2VCvzYkwy7ObhAko?=
 =?us-ascii?Q?oBFq0Fv1jlcAM3mi1SpfBemauJjfYSA6uUh8XhdVx2FRcnkzfII9zGd7Ccv2?=
 =?us-ascii?Q?VCbdmuRy4JNAjs8lpxVHcsVZ/tJtyCyHNZy1kH0e9m31DtVAi7sDJrkH7/eS?=
 =?us-ascii?Q?GhNJojY5xhvmE8teCcCZ6HX8zs6TBMj/hDOv3PikiwgYSjUqcPYFlt+SJ8hK?=
 =?us-ascii?Q?lPVyZ6afsb75f0/dCiyz1zlIx4uWJC15+nen7DgdQp9YzPCXZC68KUUMUDYr?=
 =?us-ascii?Q?MzC73kBgKKALfU3GQGyghSqf3505NGuIH2qLh7zFEzJr5HigPAGkFt77i8Re?=
 =?us-ascii?Q?w4hXzb5RLUeMR6BnCgeNYF6Pz8CLqlohcSTQfrZPC4itg2lhcsymQPwxmZIX?=
 =?us-ascii?Q?MkFa73nLeUa7Z58v1V0Ytc7zpLH+/kaLfi5R7L0DAfMu5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad3e28e-3057-41d1-78d7-08d8eb272338
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:34:20.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv2pn5Wv9moJM37xTnT5bGhMxlBNjvloqvPe8XDXh9qOnokdrBJVP/nmeF48Tr08
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 20, 2021 at 01:17:21AM +0530, Potnuri Bharat Teja wrote:
> While destroying ipv6 listening servers, set ipv6 field to '1' and pass it
> down to the HW.

You need to explain more if you want this in -rc, what is the user
visible impact?

Jason
