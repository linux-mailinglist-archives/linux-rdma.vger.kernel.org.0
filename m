Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640103F7B8E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbhHYR3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 13:29:33 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:46752
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242301AbhHYR3c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 13:29:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIfBMuQjLzQYXYa1QlJGIBjcGFjT5dQOylaObDHsukv89MG+PFmk9keXQGyo6k3DNmSwsk7O0o7mFMWsePpSPsRuALCkSFIW97qAvVlKpLNvo+tnPF0LjiGadbC9ns/PB/rFPegTj1n+HaSrCvUlr1lHWoSs5c9Lj41PhuwpqIMJeS671/rTfN4jauLOqfjzNgcV2UM3PO3qAMoLy/ibsJKjTTkn0NkzEZi6RwRq07g4x/9LfunYa3fBImyh9bGz6MCUqiwOGLqUTKQqFUzj8T5Hb87fDg0eCVklG7BGf0rtVrH+VTCpajapkYV4PUo/6r/Qs9CMJhR//eWddo1Uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbZvyqs7lCpCcAPiYTkSld3j5ot54S+Sn+xSYnVB5uE=;
 b=hxBcNJBe/kSjMs+loq0Sb7EnG5Smg4zy6xcSMA84v1dJwaufeKiM5WqGB2YNtYcu1jKkHD/qYp8QnxaQ51OD5pqNP9NKCJNvm3mQMzYb5BAoNOnlzOPDdICdBVmTkxT8lGFQUh2zw2M0ftZOGSrGeJwpWDiYOSIEA/wsY0uw5fF7QzWTTxwJTh3VvEPtUvaJcgQkDCoM7DvKDVBA5eSNmTSKhD7wrN57Ms/YuZNy0vbF0z3bjqIeoBXHuutDHi9/EniTdP2DAIhzngj1te2/oym8+PbtNexAy838klgYcZWPw1w5jrOmFeToJLD/kI8FrIzb5GQtWY35LJp+BLBc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbZvyqs7lCpCcAPiYTkSld3j5ot54S+Sn+xSYnVB5uE=;
 b=UsUjmw8lJHXPMS/cfQjyODzenZz/LRNEWqPH6p7wxElCxJoSwlK66lumGAW6IHgRIwcu5ey0aCqH5B7W/+iCSkTewwiHwbAIDZ57D73wCapIZ4un5KXFf2FApP/n6HiExo2SGYUW0K27BbSAWaT43HY126Lq7GqDhIlEm72rIVGgqU/rWNHfgOTgC9t/26NVn7lrg6NKOGKrbIjawJ/N8MVtjDOARgWlRpfTzkURnU/J0aUKJgK9g7VzMNz3NcNioqCUNAL6LKD66c2M8aCRtWBKtf+p02/jFkr8Iu6T+sRA1GipAx56UTr3XsLN1Jb8p+a8SwNzloHBdn4HWLhcyQ==
Authentication-Results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:28:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:28:45 +0000
Date:   Wed, 25 Aug 2021 14:28:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <20210825172844.GK1721383@nvidia.com>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com>
 <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com>
 <YQonIu3VMTlGj0TJ@unreal>
 <20210804185022.GM1721383@nvidia.com>
 <YQuIlUT9jZLeFPNH@unreal>
 <6b372500-ebc5-bc42-11c5-99de381b2e50@fujitsu.com>
 <7b930773-0071-5b96-2a85-718d0ca07bfa@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b930773-0071-5b96-2a85-718d0ca07bfa@cn.fujitsu.com>
X-ClientProxiedBy: BL0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:207:3c::39) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 25 Aug 2021 17:28:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIwhg-0051lJ-1d; Wed, 25 Aug 2021 14:28:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c25641-8f4f-4f82-d6c5-08d967edca74
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-Microsoft-Antispam-PRVS: <BL1PR12MB527166D8B22D137E06223460C2C69@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcvJMGg8vUyFBUqKuZgrI5fr6KLb6xDcx8Qd0ks0IQOfij7BNJsH1psq6qVITZj2G32shCWmFootM19nbGnB1SzYB3rrHH6FeIzdQC7EQxCRJBBoNGTaYO3Ju0qQBiVvL+l2VwPEhGudqhyLMUMma/RnIqwM32Iie8Ao/rWvT3m5yo/sxEYsvVC/dpfLiqHjIuNAdcFxql/BdigECp6KbOe9QQ697u/V7Z7todoFcCdgIClxr6sRygbjnDkKomIXf+6tg6qPxpZRLXLZ6q1FTtg2smvXz9TQkUWi9EbpApGwafn3cu11y4YkVwU941ZZQGfO9X04ytMmpuB+nYt6YS5ixSHhMTC5jdguQg/qXmgX+1vgNEdTrY8oHP1Ui0qYamUEkwPWCEkZFIGKNFm47Rxa3PXF8wmbaFchk/Nl1KKvh7S+W1zqWmOvmu24lda7ubG1H/RbjEJMUBz8OPXXdB/mrTgOnf5rBEevzugWjD2Kyh/cvzH3CzfEQvBppLazRPKlTL25Fkku2y21th0y0711g3tIcWCaUaFKcCRUX0u50vFBMWN0wXh+UahLcRWmK9jsOADgr/ReIi+eoqLVUt6XRrapYEO3asnot6rlJ/0eO879SbXWPiKRr2l3snfO2wYNaKAPodVIYG5HKUCxRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6916009)(316002)(33656002)(54906003)(426003)(66556008)(66476007)(1076003)(8676002)(8936002)(86362001)(38100700002)(5660300002)(4326008)(66946007)(2616005)(9786002)(2906002)(9746002)(36756003)(4744005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KfUA0fXoGCzPA5dE1HbM9aOkG2Ky1Y/IDcfTKI6+rUc/rt1DUP66BkBi+wx?=
 =?us-ascii?Q?wmcPD+XhPO/fhuxyrTsoZlsECaMnMucmFIMOFRX/SNpuXUdLZLCZqv86Jeph?=
 =?us-ascii?Q?osOnqW/PRF9LveYBqnoWbY1cNLNg5hsDUbWhEkAZeTuOckeaj/RqUx9f2t2S?=
 =?us-ascii?Q?pWbH4F3xNROYCLUDpS/wb55kO6364OdleoIrPgfTu11gG6nNX1PP7n2SXilO?=
 =?us-ascii?Q?lNn/c+ManBkH0HNsIVFisHMfgo4aDNWCL+AtjAqx2jO17nRh1I73AFrNU5tU?=
 =?us-ascii?Q?rietccBjJ4utr+ROQCnRPgMgljMqKpS7gVxcsnxMC/ndq9qNvZUIC3YkmAxa?=
 =?us-ascii?Q?82qgWp6OSyI6Jb906WSnyU6C01mZe9XsNMlVZd550MaceR7lSIs1nUbFThPO?=
 =?us-ascii?Q?N8e8j0ZM9xqzxXoNMhZJA2TFaT6Vd7Nory82G4CzklBjMhmNltUk3fC6DCp4?=
 =?us-ascii?Q?b+F8ipr4BRBlov65lFeM/p8nzObDhTrfY1i5xKfDXk64NTNGDdtU2LO7qyMt?=
 =?us-ascii?Q?GK8TqUh0j8azOSldW2VkOKEfSG+wQw3WM0pw46YUfsWFm+iUdKGoVfwG0jQy?=
 =?us-ascii?Q?kg6jSlsG/G/GQ2lr4zRyNR0vkFtBdzQTSmY2kXxZrLsSwEaJ6y5ZwdGBA+c7?=
 =?us-ascii?Q?aIcBsSVnEK7IbdgZNzj5xGk4hnJqPj7PFTczrRLqXKUdJevMDR5fpTlY1gdw?=
 =?us-ascii?Q?+N974kkxFyELddYsvKJfq+2egzdm1ceVW1co4VevtHOlmeXx+bneYuohKEO2?=
 =?us-ascii?Q?wJgu9r5wI3gtJeIIYz0QUFtpIhZo6hXDsFeH5C7KWCQT2bmPOo7xHdsUc0TQ?=
 =?us-ascii?Q?T0dCmJXzxvynaEU5g2Jpz4/707iA+mfT65vyLA0RIok8TTwYtz2pn1RLvYKR?=
 =?us-ascii?Q?OCZol/0o50BT0r9ZnB5C3ZsYuuJW8oZcVpQ3w6r6eV1nUlfQ6rdj03HBSxNk?=
 =?us-ascii?Q?6hCWzrcif57Fev2zL8alGtqsr96GIc+RIGOUF8cNPw+USH5ZrG7K29wXIAIt?=
 =?us-ascii?Q?Fi/nye6JsQ46Cs9HnNFk0V/h2cxC4ml8WZgUxwg3HvtnVE65zJHI3YOpYJUR?=
 =?us-ascii?Q?FT9IGPv2Q9+k8kIGxvzOli7lruQXFigG+uvMGdwxSuZZPzkKyW0u4SF5m8Gz?=
 =?us-ascii?Q?FctpUxXf+WI/raFl9ySGcKgLdvJ4D6Vw6pr/Q3y4RFmZ5SJZJWF4BdEesNn8?=
 =?us-ascii?Q?Tnpvs4dO3zlM0Dq2xkXq4RsK4SemZTc5rxwu0568tq+inc98CK4GTJjYloJM?=
 =?us-ascii?Q?e9t3BB6iDv8abMckRcj35XptDLlS1odOWUvgallNzW+Hj7GzmseyV35uyuTH?=
 =?us-ascii?Q?APsXAKCSsXFAmBnvYTTvopLK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c25641-8f4f-4f82-d6c5-08d967edca74
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:28:45.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oz/dPHsZGoJwRCR21q8s9hspymzxgVx92+3boHbJi2Fza4PW176FWS4+RGNzYcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 21, 2021 at 05:44:43PM +0800, Li, Zhijian wrote:
> convert to text and send again
> 
> 
> Hi Jason & Leon
> 
> It reminds me that ibv_advise_mr doesn't mention ENOENT any more which value the API actually returns now.
> the ENOENT cases/situations returned by kernel mlx5 implementation is most likely same with EINVALL as its manpage[1].
> 
> So shall we return EINVAL instead of ENOENT in kernel side when get_prefetchable_mr returns NULL?

No, the man page should be fixed

Jason
