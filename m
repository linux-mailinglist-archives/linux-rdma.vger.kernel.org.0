Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB46344FC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiKVTzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 14:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVTyn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 14:54:43 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466318A17E
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 11:54:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRq+6mfJdREq1w5p1XeoPT/9TmsdzxNRhnKIqFA+HyCP4yw8m6f/lqwbIfkVK+xO7fQIxZs14ByEIORs8oJ+0j7XnDRNbRXlUNnNV63tmOl9DeO7H+UVVkujRm2tNJiXYhX6DcTHklkuN0dLrUyuN7eDacdbj31yAqsQXLv0GE45Tl2OpF7rvNyZde6U+SzyRLaUYsgkX6ah3H8zhT1ZEUHH7rG9ZYSTehkZjQmxTsm2eJHI5mBMkuGnCsJdwkoRtRJKv0cs1uPSwRoMV+jXjDJw/QySXRO+bnWYFdR4+/IGFrLIveJh0WYn4vyo459dkfJmfXhk6L1akZVCKiiABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ulXQd336y5YbILID+/BB0auIFEgiThKXE3gOTZVLHE=;
 b=GApXcnUAyvJdxsdddSniCCxK3NimxOVdLkOx5lax7QnXCIuJ7hV+aDjjoFsQ+c8iEsKjWRfGPTDJhYu/whtZLG9Q8CbrSMynAwv8zduqkwRKbU/NxBlT57/ZIbDTI6VuV8TrbSuHhmUAW2N36+n0n1H1RXsZuaHHEXvPorAvbd3XhQd71fxOQ9e3yBWioSz5kA9h3YBCv0QVkdal3HDLhwIA8w2NwCxKZg4BrmKsxDu3SIaBMc8rNalyZmReXqc688t1jNZoQdEKcKtPMrWSw0acTvD4U4KIXVqz86w+adyIYg6IIyw/DLXCI1jPslxdJ6W+UDlTpf4R+SL7tU+ckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ulXQd336y5YbILID+/BB0auIFEgiThKXE3gOTZVLHE=;
 b=PFqmMmVyeaAx1zGRPi0FWqUqH6h66fZ8ftX1JKWfyrVOK6iOrHagd7fvbSf0ucs3t91vmf4TO8Xv3Vd1i00H/MUFMeBvY0aZaWh5Q3K8HSrPzlQucdH4C5pSkhPiGsVjO6FK7W3Q5f3cY7v6XQby+krOm2+VkFMSCrHECmuVEJGmtC0XtyEvfWpQ41+lfbDLOakDNVA6vUyzyHIx+WkLzaSEjOah6Yfni/Pw4+zJ1h9vhCJpFpjwwMstq4bW1CsmffYhu0LbRiKCVUojFpmAQqIO8qhThwq7BCRb7ky301C8aV0xd+42Qvr+6oODmvMd2XdiSlafNeeWb/Rew2NkiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 19:54:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 19:54:40 +0000
Date:   Tue, 22 Nov 2022 15:54:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
Message-ID: <Y30o/2LDLO5bw+tA@nvidia.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:160::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: c531bc09-3b3a-4f27-fa7f-08daccc364bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZQjv3Fe5qpD8tp8XH83MymxjHMNEE1rVqfiIFgtafrbGiiXhz6nm1i50eaKDkZnnxOCFOjuAFpg3HLDTUHZuUtc4FRqH2VzjPD6ecl1pyDawkVJuEAjCWQ8dQVQZJWFHW3nzDXF65ZTTKiBTvRTLr40WntqYuEQacXZsRXs2OK0Xhp2df2tAYv7WF9W4jmVBR3rdj8uKyjCtLb3guqd6WvkwaKhIv1uR05pw1IUG1PInaBSZsbA/Xw7134Meli3MNwMvypCxJYreX6AgSfDNlOecBoYZM7tlhGKcUMhy4DZ4wjD2CDecjeqj69SGJFGSCMvnetVCsr194h53qthlhTK+7Vc3+YU66mpsM/GAciKHwYrHdoZLS7ZQiPW/Vb9gN5x8I5/lIYqvgCnP32qgUUiR47a7TNaTyYDMspVL4XQHIgojTSHhH0XuEocTDnCzzdb8UzFAn4FbOzIrmk3H7+WOcgpkYFusHSj48E57ajBXTMoxjtY0A3uK09NEGpj7zsYoiHdq3a8gmf6B/TGFUePlRFWx58IQngJnbQWvxDfvYVaxHxo0NaIq0WASlIrcGJoQ08bIQXAmuFwVULdJPosRcUFQecKaJjp/G1nKa09zBElua3aBsyzcm6FJkhUEoETMYF3/YmeGk+pKLeJWLtwodYOSaXFv/BjewvlB4lI5sOPw8QA0uiGl3vOkM8tXDygeg4omfUxU7rAg8QRM/Yi+MQISIuyWgwEuqMZr4eVp/N0IfXSI3xr4ZLzXa2onT+0pApN/EzH0PY0ynWhCpztv5tibv6YJUlkbFGeWgrolMnGh6ZA3gxDQ+zRW5g4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(54906003)(41300700001)(36756003)(186003)(66946007)(86362001)(2616005)(66556008)(8676002)(4326008)(5660300002)(8936002)(26005)(316002)(6486002)(478600001)(966005)(6916009)(6506007)(6512007)(38100700002)(66476007)(83380400001)(2906002)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jLp5Bbg8p5JlkCnBTwGhQC9A7XYMU6uDZfMOtP6oOIyT2/aIIZaYj07zUwQ0?=
 =?us-ascii?Q?q/3iOwQVM9Gw1LdswcDOVpyNBNLVk4PJV9kPY+E6yz1CuOVDDWY2B9RFs5uu?=
 =?us-ascii?Q?WRlSQFrUqje9DmZh4p3ZbltP5sHxiL8JivaTO5+nLQBq2wzqvuEboqCIzVIo?=
 =?us-ascii?Q?fLzdZSzRL8ziF8nCbBNyNWM4X4hofVe+DaOVR9+Cnl7z9dYfDPWBNZHYgyVq?=
 =?us-ascii?Q?wdCPNWwT4Z54Y2TFTR26rB1EjovnH+q+W836dNMH2gf82c006FfKZmorhLgI?=
 =?us-ascii?Q?3DJBszcpr08sLIHqBjOS/JUbUVW0Hc2beUf6sKCF2rrm/QcXUIgFiBXZzqfw?=
 =?us-ascii?Q?KVuo0t+q+uhkQbgnzKpLdQ94HrA3GRCCD0irGdT+oxskTVGtmj6og5GRsk4L?=
 =?us-ascii?Q?BlJ9nuLg09AlnmQ5mbayzi6XR41Sy5MvUFWueUhrteVVBysG9ydccdZYzDv7?=
 =?us-ascii?Q?djv68WN2o5c+BmsbbLzo3vUNDqSb335/bW1BiUMtyqy1OzyYHfvNh1aAvErh?=
 =?us-ascii?Q?3lDGMDDNI5q/Axva0xYFuUhvzO1sA6JeFd5WRxzLirojYTdvzf2cnPxiqc2s?=
 =?us-ascii?Q?Ex9jnr6ugYBCZFfM3m9fXiJpPNY/OoEUyAV2sl/W3tcRI38M+gZmfzaZ9lpv?=
 =?us-ascii?Q?zW72V2YQyYoZ6YUpw1xfDGCue0nMqSqioYEKr8DXyte4NAcAFr7r5FTsDMkX?=
 =?us-ascii?Q?nZTHSXSH4guDgLGjp3YIj9ZC8iYzwBkZGAdpKFDemIUGfF9R+Gpj575RQ4sH?=
 =?us-ascii?Q?qhEIegm0ygSiI5gRlR0mcgW1WYzIu0+RSmI+EZkm6Q+Czot1DsenKQkA8oPc?=
 =?us-ascii?Q?aDybIgyKGI/+qu4x2L/HQhIm4ImQxT/qMIjZGfTt1LUx3aZGPEG8U7hwaRDM?=
 =?us-ascii?Q?2EYHZvRsA4/j1YdqfEWUK25vTQ6FeJurjZjcY28fttLWVu7a23yC8hKQXjYj?=
 =?us-ascii?Q?agdprZYsD4vB44tj4Wa4zyz/7EEvTTv8TfoUSGcQp4QNt5uoMTGbURZbxo7K?=
 =?us-ascii?Q?XyidaQIRyqrdesrq8HVVd5ST7kiHvqgsFlD4JJpTF+iS47MyqD/AthuI1KEI?=
 =?us-ascii?Q?9AmfmWYyz8MC+4uDPPW7hLBtqOL42JtAgZbO5xyt/91vE+6afUZNkfVU1zEU?=
 =?us-ascii?Q?ZEz6uPyjMqeM7xTxjjk+OE+jMBm/Whqc+TDw0X5QT/TdKe9j2jCEyyI5rsdP?=
 =?us-ascii?Q?FSHM5PH71wV9fLkeytNzMh0Wp1w9SVh09Pj6QGQWan+4vQGjyH5wO/wLMhHe?=
 =?us-ascii?Q?nFlo9zoVJ+qHJnX01Jm164En765i8awenKYp7+ndEFYWS1X+mz4GTObbBM2T?=
 =?us-ascii?Q?5STKryx4mDgVJGHhds7/MDENzv9EH+huqdHzYwlY4sAp5TysS8y2R6y8P5wo?=
 =?us-ascii?Q?wH83UICVFgoqjoLUcUWEfk4zyPNFKK3LKX5rgec24Fa2A/lrHoQdbV//5F76?=
 =?us-ascii?Q?y8B2zGzuEwTuWsly/5wszSzquIFAj64tPebAWaj/66omcz0tnGJSBgt1M6X6?=
 =?us-ascii?Q?05900YxOndY8XKPFHKc0sDgX5p/GZwSg7UMfUap12+QxKBEza7nOM++zUiiC?=
 =?us-ascii?Q?hTmkfY7sfsTImQOSdjI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c531bc09-3b3a-4f27-fa7f-08daccc364bc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 19:54:40.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrwr6b2Ob6UwA0L/NF/sFZgVLKTbBI9okNpQg+tiGsYnkIwv/cRY/ruFpKKs5Ofv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 15, 2022 at 06:37:03AM +0000, yangx.jy@fujitsu.com wrote:
> The IB SPEC v1.5[1] defined new atomic write operation. This patchset
> makes SoftRoCE support new atomic write on RC service.
> 
> On my rdma-core repository[2], I have introduced atomic write API
> for libibverbs and Pyverbs. I also have provided a rdma_atomic_write
> example and test_qp_ex_rc_atomic_write python test to verify
> the patchset.
> 
> The steps to run the rdma_atomic_write example:
> server:
> $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
> client:
> $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
> 
> The steps to run test_qp_ex_rc_atomic_write test:
> run_tests.py --dev rxe_enp0s3 --gid 1 -v test_qpex.QpExTestCase.test_qp_ex_rc_atomic_write
> test_qp_ex_rc_atomic_write (tests.test_qpex.QpExTestCase) ... ok
> 
> ----------------------------------------------------------------------
> Ran 1 test in 0.008s
> 
> OK
> 
> [1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
> [2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point
> 
> v5->v6:
> 1) Rebase on current for-next
> 2) Split the implementation of atomic write into 7 patches
> 3) Replace all "RDMA Atomic Write" with "atomic write"
> 4) Save 8-byte value in struct rxe_dma_info instead
> 5) Remove the print in atomic_write_reply()

I think this looked OK, please fix the enum thing and also resolve all
the remarks on the github and rebase/repost/retest both series.

Thanks,
Jason
