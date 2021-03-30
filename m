Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460EF34F4DF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 01:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhC3XMc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 19:12:32 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:28896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233155AbhC3XML (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Mar 2021 19:12:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjImUu6ElqN7G9irfbSgeIKxPGerRjGDyp4Q40KWHL8x4Mnxm9TeLUl+RjED5J7P0kSNqxf9Sb9lgakutpvBfYEDY5qMLLfM6LRmDpqmKehPr1lmNLZ6OcCpk0vcQHCi0fzyMFebfUEI0pa2W6Qlv/EtlGirV8u+PEEzqZVDb5Ob1SO6dGpWAy3Bt9X4qX/32I3nopk90puY6ppJ7nuPf2uLinNhpL90VAf+vvQK9aOMGpeoaooa99pfIk5itOcuhz6ygCqD2eu8in+03MfuutpeJ2UYnm8NnqRGJcGbyXqAdnMp4bbEyMPcbb9nKUKkItd29X+rm0L516SZLhOexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nUq4hRjBqqa4tKYLYphmJ7YNExEEOlp/fTtsYi1CV4=;
 b=SscXfuzQl5pGFYP7nmbvKOmhxOJ43NsuMk8QOewRKZ6s+O3+ZjeNKEFdx5MNRqD58kAPR5ME8KuPJOlA4T+y9FCpbgf4f6SDn/KVvmbn/1uZxkTbXEZE4+TaWhCr9mK5sldgwUhicI5IagbPhstwkBFCBV9USUhCnc65u7ajeJ2Q5J3M7OjWN28ng0xJ6OB02p31UzmMi1pa1bubpNgODw9URe3i8+9SxDyH2n0ZK7BSSsdipqA4NTdgujFNI+28MFnxp1RjAQuArWQc8OKYmi7dPHDmlW+azWtvEZe5dg2dLSnKgunhrALkZYwulSQhHtaAV209c5ZkgQR0MvSgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nUq4hRjBqqa4tKYLYphmJ7YNExEEOlp/fTtsYi1CV4=;
 b=mFUsR0yFfpwYuT9MrgL/RlbGqkQ5sYzdLUIaw/PPhDvzNUCzaHdYiltA106Loh6wpb1B0JQ7CXsOFm8VmGzivgycrPQ31vxMTfxRnHzhAK7qP8Vj/2Ap3jlngBvV72e60d91b/Ijpc5bg2x1ni5YxQ06MUinUYckz1/NFWUSwE4A687g/t3CTkCiAA67zYHuziH2T9lX63A7f6X/1vGdOozzC++I+9Cse+8DbHzUQu/re+fzIQkpP8SoGi09ULTV+PVfRXSoemYS/TU/XYiOq7SNGFIyF9Jrd7Bcy6NkqbSGp6NJAn2ySAnKRdhbnqlX2IBN5pHvGvNdhLZCj6+K1A==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 23:12:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:12:09 +0000
Date:   Tue, 30 Mar 2021 20:12:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210330231207.GA1464058@nvidia.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:208:1b4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 23:12:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRNWp-00692u-EI; Tue, 30 Mar 2021 20:12:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9d7734-566d-4b57-0548-08d8f3d13e18
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3305FFD0AD9A7D9F2A8A549BC27D9@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpPlkIeWbTziBBTR5ZYwCWFMwfkPH9sqq/Acwcubc1WTHnsVN4fDxA+K52VIARtmdIljs75YFI1UV7hW6rL/lrGOTmS/66FQ6VGweUUU5xOJDZWowRY4w/xB8eTdiOrcNvsyIBG93WsEe19xaYLPChK4eL2kgkgKYsqbIxtdNe2/+DCZDhAT0DvvJDXCXHlpYx9G72VRFflbfwSMvbwCbOAp3abQLD5QezYUQpWNmyXiwzlfgFC+4eiuHbAFTU71GQtiB/0/WLSOCTgdIcTwFpQ6Wk3YgXZi9VRHvXZpeaU5kg9J+XA/5if6o13NFVMOj18hQ3uwDBv5OEON0gzNgHqLeKlrpf/EWK4r2UMVMgp6wUtrAkb2JCS7dgtdnl3gbIQXjZAt/VJQzc/0HH+Pxo7eLW5nZK0G30/sNwMiaHjKVWz90jBiYf0zKH6D5Nnas106sOjGNqKMzVhW6g4AN9spDuJWG17xZfqNj/1o40/KKCMDVPevYup/oSiU3LATCXpTdaXEI2aQ1d5jsPOm8KQHfzMiLu+ZEpOHXP7Yxgz4C4fUpGYf3xS/j67osM4iwo9GJOsMwDJm/DFqVRCUiLxTUQfQYPH+L0VFhXX4ycJc4+SE/KkcS7ClV2XQEjjkZNPwOm1cAFhnlemTIlem8+BfEwSECqAsqH5Us9GMPfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(8676002)(6916009)(36756003)(316002)(5660300002)(8936002)(66556008)(66946007)(38100700001)(66476007)(9746002)(4744005)(86362001)(1076003)(26005)(9786002)(478600001)(2616005)(426003)(186003)(2906002)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dTl0bE9hZTlxUXhYenlTSTJKR0N0VDZqUGZuaTJ3TjAyOXZrVXpMd05BR2hK?=
 =?utf-8?B?MnhGMzhQVDVQaXhidFhzeDVtOGdLTno3RW5iVFpsTTZvdHNQbGVwWnBxS2dn?=
 =?utf-8?B?RG1SNEZPNS9LMSsvcDJqNXZhdGFIRnhQekpMTDJlcko5OTI1d2NGTkxSeXdw?=
 =?utf-8?B?Z0I5RVhJNDJydElFNGQ3MXlER1dBd0pnZkdhWEV5RDBMR29ZRkdjS0FQc1ht?=
 =?utf-8?B?SWFrTkZYSDFUQll4RStCdUVZdkphM0U3TDNId2pzT3ZMem1VTFQ4QUxrRC9w?=
 =?utf-8?B?a2ViNjM2TnhtU2VFZ2hjK2swM3NGcVV2VjdtN1RpOWlFR25odFNDTUQvSno2?=
 =?utf-8?B?TURrQTgxOTMzWFJvRnhpT2JBTWdudUJseHhiWitXZVpjeEVpSVZ4bEd4YUdq?=
 =?utf-8?B?Q1d1SGQ1eHJNMHNwZVllTXF6bWxHYVVMVXBEb2FVdDE0UnFxQWNIWGZydVFY?=
 =?utf-8?B?TWhsczhJditObzBrOEpZUU0xd3I1aHBMdFdheHBHYUQrT3VUSWQ1NDl3SUhp?=
 =?utf-8?B?WFMwcmtROVQvZmQwc1NTUGtmbnpNcVlocU9TdlVvRWwrakx1alppT0NFWGow?=
 =?utf-8?B?Q1RzeU1ZWG5UMkI2cnJ4dU4ya2hJd3VyZVVFTFNkK1d4MDNNeE50WHBUTE9J?=
 =?utf-8?B?MFU1RWpPcVh4bUFwekwrMXp5eUpCRHFrQ1pRNGxMRUwrQ3l3OWQ2dUN1bXhk?=
 =?utf-8?B?OEdCdmdPLzkxSEhvejZNQ2hVQUkvUm9FYTVGVk01dmhHeTdjNTZjVjhNVEsx?=
 =?utf-8?B?TkhSYktyM0ZjVEpLM1I0NlRPQk1GNFNzZU9BaXIydTNGTHF5UzhQdlVXZkNR?=
 =?utf-8?B?dHZvQzhxbjJ4cjFObjBSWTlmWitEdmt3aW80dGVLZXVGNW9WeXVhODFlL3BI?=
 =?utf-8?B?NDd5dDdUZWg4dlhwZ0Z2WnpPQkhzYjBmUElsOGNIeDFzTzg4eTlOckhORWNH?=
 =?utf-8?B?Zy91V2NUNTBuQ01uTzVQVUh0UGp4ek91ekZBUWlKTWtWM0JHUXBpbnVISU5w?=
 =?utf-8?B?SmRod2tONzRGOHVyR2xlK202QnEzeUwyeDkycHdRK0lDVmlVZUU1VXNRU0JX?=
 =?utf-8?B?aWdVUWJoWHZOT29ySnFMTlNHeDc2QkcyQThtQW5oZzA2Q0tmaUlabml3Qy9S?=
 =?utf-8?B?bHhNU09JdDRwVmc2NVY1Ujc2S1YwQTVoL2xNemVDUEJHWS8zYlpYNkkrSFNi?=
 =?utf-8?B?UUc2NFR3bTRFU0psMENNUEhsMWJNVXZuUUZDRDJWOURObmNvQmowZWNSSEdm?=
 =?utf-8?B?WmNrbEQ1a1dRTjJMOTFTMGErQ0szTkFpeDV3dGdTVDlYcXd5U1JuUzVLbnBh?=
 =?utf-8?B?UUc0ck9iYlNTdGt3ZkhFLzdNbUZ4cUlVbEVKZWxPWXBUbEMvSk55WnRMOFlx?=
 =?utf-8?B?cm1BcWZKNXcrZUtWYVlXS0hGdGpPeDJPSUdrSndNaVIrdGFobGNlSWNKQWpY?=
 =?utf-8?B?WWZ6MnNqQ3hIKzZ2cTBad2k1bnZKOFNGTzRvaHZIV1hwNVFMaEgrNk9ITGt3?=
 =?utf-8?B?OWEzVHZMYlJPNGU3SnpmNitEdjlLUnV3dlZtbUlMM0pRaXZ0Q1hGakpma1Ju?=
 =?utf-8?B?elJWYlJVZFU1YTdaMlNmWlVPUTJtQk9lV3Z4OEZtMVRNN3pLbXJXcElFbzNp?=
 =?utf-8?B?Z2U2T0pIdXRGblZSUjQrckFrMUw0SC9qbFRuK05KSWdnR1FqczdrVjdzb01E?=
 =?utf-8?B?OFNZcEhNQnVzZk1JUDRqalIrSmpuY0tGMXlJMXV3bzJTYjZURS82cStIUjhT?=
 =?utf-8?B?V3drTjdLdEtRRk9pMmJ5SXVvUG5LMmJiSlpYd3Qrb3Vvak4zcDZJa3pVRDNQ?=
 =?utf-8?B?a3FoS0ZPWDBKVGdUcGJoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9d7734-566d-4b57-0548-08d8f3d13e18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 23:12:09.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WK9wLAW3TX6KeYPzBwgEXIIMFAx/vEEI1Isr5wXxKJ/Y+oQoBWKYoTjGgc/bgCIk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 02:05:47PM +0100, Håkon Bugge wrote:
> Introduce the ability for both user-space and kernel ULPs to adjust
> the minimum RNR Retry timer. The INIT -> RTR transition executed by
> RDMA CM will be used for this adjustment. This avoids an additional
> ib_modify_qp() call.

Can't userspace override the ibv_modify_qp() call the librdmacm wants
to make to do this?

You'll need to make the rdma-core patches before this can go ahead

Thanks,
Jason
