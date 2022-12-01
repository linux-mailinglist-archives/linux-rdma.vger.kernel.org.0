Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7E63F100
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 13:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLAM6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 07:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiLAM6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 07:58:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1955C8B
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 04:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcmArs/EFS+IcYvAZhc8RFPyyyYjb32+LxIldpIAgrFRKrGgFcEn3dTubb3d8BS+OYqOzNqGgpxy/RGsl/ujv2ItE+7+n8UGJBktllSZ9UGw4V55ltBc05OPL7TRMl/bcKgle5CDZ6QFND4zuu43IRgWUwrJ4eXKbpV+4ycS1W7CIZtqcqdM+sgUpuS29ZxfpNwoDSm39uZt/BfV1comwrDZw5YxDlKJ8F4Yw1r4uaFlVMgP1wuv3aSUkFpMbxrhJpTjqrw74LM+lvQ6IJ3qMK7gfUG2nFgpIhNwXENwkkS8rPzvkuNcldhOoVOOUCTlNnAl1kc91y+OBJhiiUWnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJcMrHx2apIaCTZ+WaopDMWssxnnrPdb5PsPKMjOiXE=;
 b=ZNRR3nSgn3w9LnKncqJnWqpHGwt1BePVyFYKsQkuMLuib1tH/VPmuFQtmOUb6Oz+jRoyV99MdFPnZFMpalAGv/5UKTet65A1o6MmoGDehMbVEVS/ePKPNXquLLtD7NsWeZfY9ylS1jQxWAd7MSB5MV7u5mX7csgwEE9EjrkP4TicTATZCYtaiwabmNefOHwQNbljFQbcTxhafy8+sbKT3STCBwAJuT/kj/hv5IXbGYR9n4Xbr9SFbgoh6f4rrvTfosXfQqSX5zQRbo1PfN3ABmRphB9jsJTQ0oPcPHNPhU63b5V2hO7BNxH3B7ldG2Lo01cG1IwG+AbZ9SJqIbZjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJcMrHx2apIaCTZ+WaopDMWssxnnrPdb5PsPKMjOiXE=;
 b=PuZv2bme3gbVqRvEIIhZsyeuy+BUN3tX1XvwXf5hcGG2RnFwsy6/uNhFPe4nBeCLYyMN6I3RkFrqcR8ZDrJPM9xYbP7hJNCWpBY6HOaqAm78RulCGvD4RYIXEMyzRlSHdJGwXHF4zuqbXKwGakPBW6YLgYRvT425GSnkJL3qlX/suVG9r023m4kKynYNaRl8oZTUK2pBZYVoDa950UmTj/2vWWKHDQ9rPoRyWWAJiBFUh/Fy8wNyPhoRbA/5+HWWHttPuLOz7X4jwuV9JoQsI87d435k3trqXCHWsDW5P5me9xJfKopbd/Q+FAO+XEit3DdYZEUYHpqpUD1aLMldxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 12:58:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 12:58:31 +0000
Date:   Thu, 1 Dec 2022 08:58:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
Message-ID: <Y4ik9iEfvMNefraR@nvidia.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
 <Y30o/2LDLO5bw+tA@nvidia.com>
 <c10c62d4-fee9-4824-1383-8c6cdcf1c71c@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10c62d4-fee9-4824-1383-8c6cdcf1c71c@fujitsu.com>
X-ClientProxiedBy: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c96885-bbfd-4426-69ee-08dad39bbf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpQ43F1L+iuGpcNOdG9VFgvKgu7w7883Ogx9fSvR2TM5LRzyIWCkp/7TivNpJAku7C4JrT9hwvFMo7+AO1b1Idn0yPJPMnPTTYtjqa1+N+xe6M+trTYqnG81Jvy6eyKwoP98UtJv/ss3reVj8KZBogmAdziUGAwW5K1DEA1PMPeT9hs5hatBjuShJwaPtv86PeHxkvOKE+wjEGovmp503qwqb4WPI8UpnWYOR2mnGYo3v3Q5klXhJveiI6T79N19qPX1A1XRxLo/lRs2ohWwwpA/flKxZMuudeClh90L3QZ4MsqRUQTJZQ2jeGoMC6DWi3qjzrVJZUrmPTGO39OlHWiBl28V4pAtfoqypFkeEhWN6IwebQ8+f5dm+1OtF5ggShbPuqJlgcu2crOKyJzebowyM/KaxjQk/j1DvdIfBRpRSIq2x+xIZpkW8jJJeSpV1h3oSwpMHjX66aw15BME5e26JaBToY3OLqgp7ar6V7fbtLXMo2NTUhLnlpZzUk1dPwOKutd1K6KTORzDgCLSq2FAUv7mhF1hRQJxuzK5luI0dCNLCFpttNM0vivPG3fchxiUVZrd+Rv6FM/dcP3OQapZGpc+O4/bNeRBtVjuO4RoaoEOBqv4meWHLx5XJLSWicLam/XrwEy9nce+qOxqVCktBhWhYmr4CVcUjeLNnSdJTugHqAOF9DFsihu0GLCD55mDAIojqmVG2/dBpN3Nwz6ucMiskLFC0dRZuRI4xbrvvfNR8G4DblOmylEjO/R5uhm7DYuaVloB1jjYqDGrYxaaK9hBDYXNU+Gr+3DNs15Lld3BIP5j43m9qX7hZ9FMNjcfuVrHqO/dSBf+d/a3PNkqQXgbiUYCkC4SjEijM5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(41300700001)(5660300002)(4326008)(8676002)(6512007)(66946007)(66556008)(66476007)(26005)(54906003)(2906002)(38100700002)(2616005)(6916009)(186003)(8936002)(36756003)(316002)(478600001)(6506007)(53546011)(83380400001)(966005)(6486002)(86362001)(43620500001)(15398625002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AS7sfKDjfFlH+0beFkLC0vITqUjnqxcThtUgJ8gp7p9l0hUieT9AZXHPj7cj?=
 =?us-ascii?Q?cwou66YPrMzZf8h5PqNPzbvx2TuV4drVkFJ1Hh/3rWgpelwdw5yjMb9E6Wsh?=
 =?us-ascii?Q?8OFFbjLkkTERCO0T67IoV3+f3WexKdv557yDYlPVVg7XEq0sp8OmsPogdLDk?=
 =?us-ascii?Q?KhLrdd1rcYJI/CTxzVQqgXxQ5kmp8fLn/rTMX+RLKx30fL/Wmo4kP1gGa4HM?=
 =?us-ascii?Q?uOwJgNK9e5lMbtOCi8qTI0P35+oFhoLLDCB0AQB9+jppkiYFN0AjnqJ31YxC?=
 =?us-ascii?Q?MThpmxDesmbva3X1Rfvhxr3af55uColnA+N5ToWtmPdLvUopHlKDMPkeo0eB?=
 =?us-ascii?Q?Ai5whx5HvIbhqB2HA5DbsIVxnNJZ+RoA447Lzp0rD26ihzpH/dWKlCW+DWAs?=
 =?us-ascii?Q?7xeyurHZzNrs8p1XHz/QWnSZ+q5PMeVThFS5s121fuh9cL+2efvC0hGfEMLR?=
 =?us-ascii?Q?4a8Qpmy68VoQvD9GC4Vs3MpKH9Nua/tvOYBB2c4Dww3yYIb0EnGKvxKadLgI?=
 =?us-ascii?Q?cFuigloMiagj1HqWi5wuaica6D8Gweq/cNR++fmuDJqQxjsD46nLgd2TK/xR?=
 =?us-ascii?Q?8pzTLELMkGELaxm0d37kJPJ0LzDythJwOO/gluNW2/7djsoS3ktmVq6sZUky?=
 =?us-ascii?Q?AKs/SOGavJgXCSbsveWYBvwaf0uHR6YR/3dsL03gLtePbX4th5QzVxxlSFN4?=
 =?us-ascii?Q?NEJddm9G5lQsRFU3SUqZKD1KqXWqofcxD5K1jala1UV4gv/cDWuJGKE3p3jl?=
 =?us-ascii?Q?X8K88z/sCekZx631t6N/pfEBnw8Qs4Atl46sdjUWmfw7+43aXH3QMFSsSU5F?=
 =?us-ascii?Q?o4cMcovkuaLBDsQXqoI8Uo5FoBE7gvSoO2e9w/FkpBkCGpJMAzd3DYWxvmpw?=
 =?us-ascii?Q?/qxFo6Bj3St/o8qmFWxvGyAvoDhg3hUwN1wSyH8/7BK3EyuRSgOkwbxAsoMa?=
 =?us-ascii?Q?5u1j1yUR7KdVXZI3UUlizqQcf1N+NsVudBZMqKA74nxSJIg4eZ5JjEjlUPog?=
 =?us-ascii?Q?h6Ne/rCCWQr46YiA53KMzGK1qGnC3R8zctrTknTzIsqzspsLwuQfw+XOJlZr?=
 =?us-ascii?Q?g2qP6t8YgQjO10wEBgQxeby80Z+DJUnm7t5NDjiCmHdU9KMjD4DcWGck0/vn?=
 =?us-ascii?Q?Cx6AtpNO44LhtbYHDhsSZ540jifjXqreiNd8svv95T3HAH2tg1b5YyeFwUuw?=
 =?us-ascii?Q?ZUP337rcQ4URm1qLE4LmhJarqUVQ58pQzAOgxSQ/9ZpNpWDaCRSjHLTwJYfo?=
 =?us-ascii?Q?2Dwb3ju61V04clX+j3GMrF5qJwoSUci4L/Blu7zJg4OTjqq7rnAxK915M3zn?=
 =?us-ascii?Q?4nE7mjfp/18gEkeSPh58HMNAUGQi/ikLNDVXKg4kBVa+F98XnhzIUi+USTHx?=
 =?us-ascii?Q?0gDQKJZl0J9PyuO43Z0xcJQ0TGaVwpWfNNyIeLNX7G146XAm8VNG7bpShTKD?=
 =?us-ascii?Q?n4sOtZWmZlYBYYiszsXOX2PEosLOWIF3Wa0OlySvZHi9rrd2TpkeuGxW78q6?=
 =?us-ascii?Q?pKD+hu8tSZ0mEfDJQI9th2d8PAoVvH2OdlvZgBrDo2Iw66jSUqSE5F4ypxjs?=
 =?us-ascii?Q?BDI0CV4vdh2ByLxRhoQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c96885-bbfd-4426-69ee-08dad39bbf6f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 12:58:31.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DL6rnCVHXy87SFyPH9sqk9ZIiWJ6ig7D+hhYrDhPjCyCnOtC/bRRh8zs01dnB9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 07:58:44PM +0800, Xiao Yang wrote:
> On 2022/11/23 3:54, Jason Gunthorpe wrote:
> > On Sat, Oct 15, 2022 at 06:37:03AM +0000, yangx.jy@fujitsu.com wrote:
> > > The IB SPEC v1.5[1] defined new atomic write operation. This patchset
> > > makes SoftRoCE support new atomic write on RC service.
> > > 
> > > On my rdma-core repository[2], I have introduced atomic write API
> > > for libibverbs and Pyverbs. I also have provided a rdma_atomic_write
> > > example and test_qp_ex_rc_atomic_write python test to verify
> > > the patchset.
> > > 
> > > The steps to run the rdma_atomic_write example:
> > > server:
> > > $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
> > > client:
> > > $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
> > > 
> > > The steps to run test_qp_ex_rc_atomic_write test:
> > > run_tests.py --dev rxe_enp0s3 --gid 1 -v test_qpex.QpExTestCase.test_qp_ex_rc_atomic_write
> > > test_qp_ex_rc_atomic_write (tests.test_qpex.QpExTestCase) ... ok
> > > 
> > > ----------------------------------------------------------------------
> > > Ran 1 test in 0.008s
> > > 
> > > OK
> > > 
> > > [1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
> > > [2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point
> > > 
> > > v5->v6:
> > > 1) Rebase on current for-next
> > > 2) Split the implementation of atomic write into 7 patches
> > > 3) Replace all "RDMA Atomic Write" with "atomic write"
> > > 4) Save 8-byte value in struct rxe_dma_info instead
> > > 5) Remove the print in atomic_write_reply()
> > 
> > I think this looked OK, please fix the enum thing and also resolve all
> > the remarks on the github and rebase/repost/retest both series.
> Hi Jason,
> 
> Thanks for your reminder. I will do it soon.
> In addition, I have resolved all remarks except the following one on github:
> EdwardSro: "keep an empty line at EoF"
> I: "I wonder why we need to add an empty line at EoF? I think there is no
> empty line at EOF in other files."

It is not really "empty line" it is that the last character in the
file should be '\n', and all files are like that.

Jason
