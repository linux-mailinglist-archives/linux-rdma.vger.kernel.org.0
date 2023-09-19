Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296737A6481
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjISNLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 09:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjISNLm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 09:11:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82842F4;
        Tue, 19 Sep 2023 06:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbYZ4bjm9UY3gzIXyQMsWcMNILoxzmRUYjnDY462+czMEMU4OoK4jp5QraraWRyyjWwpEi5lQNyawnvBO4QBf96kC8/TVKjORIs87lboCTCHDAEo2OZgtyhTHy+QEwRfWZk+tuAVMiU6IwCyg0aeUT91N8+pNUvyoxdAXJnnX95EIU1Df1tUOecm5v3BbEFyrOnxXEMIeewWrdS6fmMfMAIUuSRwJHEUjIY1mFhb/qUMGnekFBiewrEQN1j6nHmscxMgqn2wDhTbzP7U2SanB7gGOE/sv6m9DGxn2uVWc72iuogfMvvFHeY3NGYgsWIuUpKSe6by17+fhmFqfSpHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtBZkabdS3xUF0vOnQ6ZRg+4B1ZjlpwaL/vkLZM0lpk=;
 b=PvQAgkrRSvfcYnKEC6uN0UxQ7jLR/nhN1gGK/vxY+bveqyMCVfcaRc96vaNPVRZ1e+kLwfUa4cmmVFLK8NfoTEDXv6d7dDd3IUwDSCTH/3jrV0dscy0fdseLGksNqfoqFBt5gFSFqLbNuIEUAkrmwU3GGVGgHYKy+xJdOE5MOnOnWIZNdKL/UfUb6n3udGk08GJ3f4yMrhezFdEQ2MI+QNbER8TRwRw+olhouky6Inae9LcoHtHbaWk/MN1czxcpVY0zrKSwhKZ+TNOZ+sGj0HRru8oD/vP8dCldeQaAk6C5qoWoN9YsL1aPICiu3eJCtoShU69dzSoUzZA5/b0/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtBZkabdS3xUF0vOnQ6ZRg+4B1ZjlpwaL/vkLZM0lpk=;
 b=RjPATQiQYa+/qGJoxedVQXe16sERIMmJasK7ZgMZYCs1TYZFF7ZGGG+rn5D4Hg9fzfcq3AV2pmmiqgqJWwsBEHgx63RD4gdPs358eA+AJTwSZrt2OAYm/rB2pMoO5KTtsTM2719M4iR8tf/nuU8GRB/5Ua80NoHBkb07oEALlQL7lbxgcDcrXtKcPcCwqBTJa3V8N1oyPJJ9L38An0FeRF3ZPtxgSnqG5jk4xGffyAixQg6PvfgZ44FhZrmkMHSQiKY8KBOO0AsXqOfh8TR1tcxaScCq5jUswh6a8vt9k/mwnFlyPWwknThHmknnVlis7WyoYx20IHSP/Rd+3i0gWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 SJ0PR01MB7495.prod.exchangelabs.com (2603:10b6:a03:3db::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 19 Sep 2023 13:11:30 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:11:30 +0000
Message-ID: <c7870702-dc6c-4673-ac5c-04c81c463bbf@cornelisnetworks.com>
Date:   Tue, 19 Sep 2023 08:11:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] RDMA/hfi1: Use FIELD_GET() to extract Link Width
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
 <20230919125648.1920-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20230919125648.1920-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DS7PR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:8:54::27) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|SJ0PR01MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bf9bfd-724a-4b52-24a4-08dbb911f083
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hgx3bUmWHthNg/sxdLlEy6bWdMF/4V/+QzJt8rOlxVykd0AUJXbefeoQMrafCNn888hMvjpn/Qzpvjy4i+fXP3lom2KfclKVVa7WnO2POtyKd2Tppng0vs0xGCjq3ecejr1Bw+9evyCATsZWpLDpHYCyzW8uZ7fBC9yBdZxT70IUgzLzFYlZRkUoQCwnx8i8Yvc0jRBdDe44JvkfFRcOAddTVCZ8MkHYsbTHSDl0ayqc7yiJ2YiJlU2r3H2Zy/YaUuh2McrDU+plZfFG6DzeQl6z7A43VGSz7Wo264iSEnbHBjX1638awWk+JucXAkjTMqWoMcS5ILeHOHL8rRIESjuZV8Ajlu24liR/xKquneS2erTolNDrbGqDOv9nTkGR5zjipDkZspZkvxhOOMJcm7RJ6MlNp2WqF8H4/Gn4O1ktOfMfswbVp9zqCwD+Crc4sF2WptoewF4RNgiL5kzJsp9NLosH6SoBbrEiqBJqeAyUwF/fq3g3Pt03eqdcky8YTa+AwYGBAqMcq1wL1TwJUYS9rr7xlGz0eohWqwrnkN5LCmmrIfvYcJs/4hOKRwctv6+a3O/v4skc48e05YGFB8Bl3xxd+7dXBiMykrs6OANo1mN/UDoRZmUUxxmxU/K0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39850400004)(1800799009)(186009)(451199024)(86362001)(36756003)(31696002)(31686004)(478600001)(5660300002)(6666004)(6512007)(6506007)(6486002)(110136005)(53546011)(44832011)(8936002)(316002)(8676002)(41300700001)(2616005)(66946007)(26005)(66476007)(66556008)(4744005)(2906002)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXc5dTBxMXlYNjBtTVJpRnlJYTkxa0d4djdWeFQ1VWI2S3JBb2hheWJlSkQ1?=
 =?utf-8?B?Q2xsMkFJcWdrZkRKQ3c2dm16Y2QwTlgrVXJMclBzTjFad1FtMXFwQ2JVQ1h1?=
 =?utf-8?B?UXdvYzJic0kxdEhVTWtyZW40OFVDRzF0QkRhZ3NZZ2FZNVdkVGtqNllOU1BR?=
 =?utf-8?B?Y0I2d21hZnEyV3ZXaFh5YnNIUCtJdU16QVNhY08wbmFkTm5TOFR1M1dUZ1RK?=
 =?utf-8?B?dXgrOHdXYzhENzhQZVc2c2YxL2l2ckpTVHhGOWJtZ1ZtV2hNV1VDci9GUUJQ?=
 =?utf-8?B?anhRWVNzV0NJRHZnRmZ1dHd3L1F0cEhXOEx3ZVd2ME8wL2xaZCs5U2RGMGFP?=
 =?utf-8?B?Z29ORTE4ckpPUi9HaHQwaHI1QnJDRWlUdmtsaFVtMzZuakNoVEhRSWo2K0ZL?=
 =?utf-8?B?ME5JMDhuRE54cytvQ2R5eVBrNkQ3cWVFNHoyVkdOVG1vc3kzNC9SWDVIa1pI?=
 =?utf-8?B?MDkralVuSHY0MHVMNUZreHdhb2VKUnZPZ3AxdVViNmdXTmV1cEJzc2h1K0ti?=
 =?utf-8?B?ejdRczVPc2FKVTdvNktZR3RoWVhudTNpNVQybjh4MTI2NFNxSXBoa1kyazdh?=
 =?utf-8?B?SGUwa1VwbzJjbWlObmNMUUNidVlPdFBOZlo3NlFlR21lQ1hoajJST0dvczNq?=
 =?utf-8?B?N01Sc20xODY5ajVWMGd2ZjdRWUFTT3lCbGpIQ0ViaC9Wc2JxRjdGY09Vbmli?=
 =?utf-8?B?d1JLL01yTWZTRUx1T3d0dVc3UGU4RGVVOTNuQ0pxVzU3WWU4ckV5RHJTYTNN?=
 =?utf-8?B?Vm1CR3Rra0VSdnloQlppbW9OelFyWWdlcjRJV0xDR2VKVm0xYzZaRC9LSzQx?=
 =?utf-8?B?cFVVajhmTnpzdEVMd21mSGVRbEVUNkJCNG5rZndBa1NnR3dMOTJHa0M0QkFK?=
 =?utf-8?B?VjdJaGVvV0YwRmFyQUQ0NWduc2xaRDRnZ2NrcWVoUVgxS2xaMzFTRUJxMExH?=
 =?utf-8?B?bGh6VjZxZUZhdjI4MzV2a2FvMDI2czRsWmZvME8zQUtLU21OTU1kT3hIZTZW?=
 =?utf-8?B?TElZdWV6ZDRpMlVHLyt0bmFJdTd5OHBrN254a3N4Sk1GRzVEd2s3cDNHc0lO?=
 =?utf-8?B?QzhaQ1FlWm14TElJMFFNSDhiTTkxOEhySER6L0NJRjhQSmV3ZUNXaVdHM2VD?=
 =?utf-8?B?WWRFbnJrT1FBMUlUUUdhMjZ1WFZNT0IyOGlVVmN3M0xxNTVmcktMTXdsR3Q0?=
 =?utf-8?B?WVNrdGM5NVdLa29MVzg0cWsvYmVwVDRTbXlNTlNhcVdlaVVqSENyVEJnQ2Ex?=
 =?utf-8?B?bkQ1ZWlSUmN4STE3MlZwYWgyNWx5T1o2c2dkdDdxMG80NE5tWTRMbG5UMm1D?=
 =?utf-8?B?RWNVWk9EZUcrUW90WTU1dHZwK1ZETlMxNDhBL2VjUWtJMEc0VFZWNzFJMktM?=
 =?utf-8?B?V3luZ2VUK0xNNnBuSnAzS0R6djhXQllNN2ZkeWpGbTdvSkR0L0R1N0h1MDlw?=
 =?utf-8?B?REFhTURnZk9oemxNVCtRemRqVC9IWDFvZHRIZ0ZhU05iWjNBOTN3bExBTVVy?=
 =?utf-8?B?NDRpOUFQUG03MHMvVEY0aXVaMitFVGxJN2EyU2RWQlM5cndoR2E4ems2dVZX?=
 =?utf-8?B?TktMOXp4akkxekp2V3M4ajloNkRMMEhCL0p3MkM3dlRNeHhiclhWNGZWaGV6?=
 =?utf-8?B?UGFIUWlIUmhJRUVyY0NwRkY0bVJZdjhYbnBIbzRORHdxdmdKT2pTczdsbUIz?=
 =?utf-8?B?SXRUVHlhQkFOWWcvN0xldDM3WTFYUFhTTVhGbGdEeFRqZUN4YTNxbkZvWHAr?=
 =?utf-8?B?V1JvQlk0T1VpM0drZUFYem5abEZkRXliSFlqZ082ZUF2VEU5ZnlHdk9JMjMy?=
 =?utf-8?B?NVlxTytkNzluMlQ2MmRKNk1sR09TbTFQTSsyMFh6dlRNKy9SWEtsT0twZGRE?=
 =?utf-8?B?U0tiYWw3ajFPdndhV2FrSHc0RlJhbDZ4UGQ2dnZsbFRESFR5ZmhiZFg3OGd4?=
 =?utf-8?B?Y3FQR0pUVFBEQ2NmenFwNnBlc2xjWDN6OThQZTBFSUJXNmNuOWRDU1hNdkhp?=
 =?utf-8?B?UFFvSmJNaWxzdWp2eDBrVVpMMjgwa2l4TnIveDVIQ1oreGp2dGxMekNyb2g3?=
 =?utf-8?B?NWxkMTltcHFIdHhNdFFtcVV3RUVLVG9zbTZ2U05RR1hkc2VmQWpGZnVNWGZm?=
 =?utf-8?B?bFJjYTJnLzVRVXVXSWhmcTg1cWRkYkpoNGovVXBjVE9vaGdMZ3NtQUw4cEY2?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bf9bfd-724a-4b52-24a4-08dbb911f083
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:11:30.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9nJ37vFKZvuc5n479djOItpSNBU3ywgRAoOvMq21M7C/Z3CoZpcrxGxjhQ315JYhEDy/yPirNWfG1pGgslRtQLb6YQFFlJWmDaDmfqZvrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/19/2023 7:56 AM, Ilpo J=C3=A4rvinen wrote:
> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting, and remove extract_width() which only
> wraps that FIELD_GET().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 9 ++-------

Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>


External recipient
