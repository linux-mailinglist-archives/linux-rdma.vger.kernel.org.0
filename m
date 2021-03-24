Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862CB34788C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 13:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCXMd3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 08:33:29 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:20960
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233797AbhCXMdN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 08:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcPV2Mnop9xeUbUALsJ25DDTiMPbbc5Dn/iSIhKJQHEhltnXXl0MZM99vswZHLnd0ZcLlFNY1appRG3EMv9cD+vTk6UXWgE47tw1urKws/5pjhfp20hKWCQxGkXYVwWSV4/kH+VN/X+QI6KsytKXSzmTFQNHpGLnbHrw0X5rwfXH7UNVmJDHzgECIHhp3CaFPVXX4YIwvDHGZx3uobNimqn1XVgOf2dlou/ev7b4NLzJii+hjJYoTqhlmpQ5ULpLOuZ9x64DHHVsNnSy5EvAoegNU9joUtXc8zSC3T9RNWXFDHfoDRobJA/xdUVmIS5OIKbUD2k8gvQHFnEHp1U91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeHEioucsokUfWde/0ur6+/TTDCye+tPWePO+0w5jPw=;
 b=bkxDCZzz2Tngt9BhM9I/ElPDCyVvsAnVMFBlrtR2cELMSIilWyEqHH785R/6/JTfhs/S9qOmVyJfpkD2tcl6JkwggqbDO1qB/XRoqtu83o8ykAfmNmnfK5L/tQbHobIbYsDLx8i9jZiiQfiPRX/Ji5ZSX0RJPonDqkc8T+RAsMv48saOPtSETaJaw6Ki6uka5kSvl5eNYSjs7p3PoUr7L+4V7ua9RSwUDxLtyq3v8iyuAwsw3iDkOJcd9clJZw2o6gN2tBJjfk/Pk5ufGkkc3j6FCAKZVekfmi3mchGWdV3sAqm1KRj3s0ucQ61/bne7UWWq7GjEnx10lfQh127ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeHEioucsokUfWde/0ur6+/TTDCye+tPWePO+0w5jPw=;
 b=Spican4qz4ZGGr3dTT4bWYMZT+loRArYzP2CX3YcU7u4JGpOExhHzRkJYW4vxy9JhefhEGJiXMyWb5VXn4PL7IiIDsUFGKpRaMnvdO/d/9wi/gcB5s+TQM/dOQBPMyOiZqWD+gH5NDxTwZYttV2U14BhOcOOsP5QHLT7q/nd4jot6MP5Q2BcecVxx8Owfvv6iWN6zquYYfl8kApw8hxmdZWGvvvNT4q0cPqX7L3Dr/YXPRczTXmfR8kd3WefS9snYGEqd3urrOzsmZui80kb62TrFH9E2tlQBoVsjaH9au0ZW3WauT3hMZtnJx2qSiDNXV1sS2a0XMVeHS5vfnVVfw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 12:33:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:33:12 +0000
Date:   Wed, 24 Mar 2021 09:06:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Support query information of
 functions from FW
Message-ID: <20210324120634.GU2356281@nvidia.com>
References: <1615542507-40018-1-git-send-email-liweihang@huawei.com>
 <1615542507-40018-2-git-send-email-liweihang@huawei.com>
 <20210323195627.GA398808@nvidia.com>
 <df637ff2c0dc4d20b2a01c8400c4ed9b@huawei.com>
 <74c5373f541f4f3282795f7763f198da@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c5373f541f4f3282795f7763f198da@huawei.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 12:33:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP2HS-001yMt-Ii; Wed, 24 Mar 2021 09:06:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd337c2c-4382-4106-847e-08d8eec0fcf6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB143543E05438B6EF078FD91BC2639@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxY/1nwwXAeEsCrdni7yXs4ss4ufOv0hVQ6LavIVwGPErgJHnYpCHwXnn/kIcDvFjXrZ9JMQBi+7+0EBORQ1IzDFSG/INs/ViiZuxQfHe66rPrEsASkmk1KihdM//DaFdQ8Cvu5N6v61v9+oMP7+0P90nF5/4UvcGOWsdfFSWkIqbGmq2jJlSP968zIAv5wY7+NLh1iS5HyGuECz7UewVsxfrcx/Hod+prONZc+gZxevior8VW5WY1h+H0wfIQEd7u6yNn2M5/Mv5GEyuJtG+lvNVYDxaPeN33rv0AWZLCo+DM7+lZeXWAZj1cryQG+qF3+i/e03wQgrL8XIi5b4Mm4DDcDiU2MnGpze2rdClxgouqtElUvMRDTalymNabylqL4haITxPVU6OYGYn6nj4tG2QRqOUTp7W0t527UZvKjA+tyDxFzd6trz27ZLr+0xHTsvPds0R6YO1pWIPDVnyDLNX9/CYf4fVFleO4XsJkAgxUH04O2zWNcXA+ZrMOtaAbbT2yP5TC8Z0YV02WPX5FAuSzBfOfX9FZNHKXCdZJ1HiEkBjUXqHUja+FwTZmxGGGEUX2ytEV6W0FPgo6nqfMivqbaxFoDBIZqZ536U9pjCZb/F8rEM/o1wNma1YECHTwgenn4wINGPs7/QZulpw4KgnDtFj4E5Fog06X6pZ+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(83380400001)(4326008)(9786002)(9746002)(8676002)(8936002)(186003)(86362001)(36756003)(26005)(66476007)(66946007)(54906003)(66556008)(5660300002)(38100700001)(1076003)(316002)(2616005)(2906002)(426003)(478600001)(33656002)(53546011)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JHIT7u7FOtpiZO2VlSl3p0tDomWda+9RDiYhtNL7L7GFo/OkRcUO5/hZ/FND?=
 =?us-ascii?Q?Jk7X6yPiXcApJScdVAXEBph8KqWl+74vQ9gJgmaaUf0MdvBYthyONLkJl6uh?=
 =?us-ascii?Q?4XHVz4Yja9T9boBqP1Ruosih5Kgp5Y2HndJOeuC8R0p5MbWbecNzchZjzcdD?=
 =?us-ascii?Q?vufrY1Ozi4BnPBtxbZu/zX29Cbe10NziZa1b+BU6R2k141YDHLRRAvjmCDut?=
 =?us-ascii?Q?85LROSN7LG7cyNmHrIaAuakljcVHcntXzqH4ZvulytljbC7ezZUOLwJTzH+e?=
 =?us-ascii?Q?PfWiiOFHaPZoizgWk/mj01F1D0RFmmnOikmCtw0kEshPxpIbAf0cndC2+HRP?=
 =?us-ascii?Q?c3Gfb7Xj7yJC8qvHQkktPgFUyn2a8uxUe2LvgsdZbsYdspu9Fks5NGR5VPd1?=
 =?us-ascii?Q?7VE0iYDAkvSYZMQ4vslMPt9a9yJMzm8ohu9PuIWn+f2HB3lX7a0AbTCBAfXR?=
 =?us-ascii?Q?8sILS4bOtqlDvxu4yLPJmQqv9moSdiwxXZQb5wZD9sdmfs3x/hi9BvdFK+Aj?=
 =?us-ascii?Q?EkR/+1GsqZpiSpBpNI1XaoKNeysOmx/R32zqiL1w1pZ13UvQ6no0skCHuLSY?=
 =?us-ascii?Q?ppjQJZ8d4k+kC1xHce6qbK4yAJ/hHhXgklBMd/xc6qYQFJtgCJEwcgT3wu8l?=
 =?us-ascii?Q?PoRprlccC1Qjioxn23g4Dvl05Y3SXqKqDeTYGoI/wskZfX9aJu3vh+QpOY/h?=
 =?us-ascii?Q?Ja4KHNNYl99walkodcvwTh29eXuriyXoRLKUm7BgJf+a0QTqQy8rgY0NakYx?=
 =?us-ascii?Q?piyMTBdlQyEs5gb50yTLfv8AX+u/Z0lU5qyuxL7dzWCHly71XUocHmYMiS2N?=
 =?us-ascii?Q?o39X4Pu4bOtIYXReD+GqJkoZgMbIrc8jVTa4TWMrYYRZxqJZbCBL86sVk4yU?=
 =?us-ascii?Q?ffyj/K0abDdDOOcZIbtrhNOU3esiKyyKj0lJIeWmMlja8fuO+87g0fQDoNnR?=
 =?us-ascii?Q?RiUoNIUZ3JFSCffh2HA8zKIo2tD6f1zWpVAsqMP/AZGhnkw9dWoFW3+q9Cx2?=
 =?us-ascii?Q?zdkXdlfY7FDFBZkTFIz8PmCO/VKpoH+yy+NZO4020rHdtbgRdAYJP8J+oE2q?=
 =?us-ascii?Q?ClcHn5jNmDFBwPMBPffu5MlAh2/VmQNwwXT/t8fZ88KuG8XXaqbf8/8spbv2?=
 =?us-ascii?Q?f0a4qCW5R8Bf3diyb4xsBIwmbnLi3tL+sF5sQxf4oR1aHmU8mZcbvC0dk7n6?=
 =?us-ascii?Q?b0mvI7ajfq5V7KJiJF8zNKAbJcypNsD1ITtcPvKKiPggKnqspPmuKNdR9aru?=
 =?us-ascii?Q?/r2/+Ah5YjUUcfYY1oyRB2JeAyBBbtqVVmO60xcAnYdAxxpIN/OVv/YVfrQu?=
 =?us-ascii?Q?rlqCFndrRxegB60f+edKjQFg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd337c2c-4382-4106-847e-08d8eec0fcf6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:33:12.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnLZAdL2UoW1EyusM2hlfzQl3iweaZqVJLePFE8wRefzd56hwKuhvpcUA+Gz9xCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 03:07:47AM +0000, liweihang wrote:
> On 2021/3/24 9:55, liweihang wrote:
> > On 2021/3/24 3:56, Jason Gunthorpe wrote:
> >> On Fri, Mar 12, 2021 at 05:48:26PM +0800, Weihang Li wrote:
> >>
> >>> +static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
> >>> +{
> >>> +	struct hns_roce_pf_func_info *resp;
> >>> +	struct hns_roce_cmq_desc desc;
> >>> +	int ret;
> >>> +
> >>> +	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
> >>> +		return 0;
> >>> +
> >>> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_FUNC_INFO,
> >>> +				      true);
> >>> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	resp = (struct hns_roce_pf_func_info *)desc.data;
> >>
> >> WTF is this cast?
> >>
> >> struct hns_roce_cmq_desc {
> >>         __le16 opcode;
> >>         __le16 flag;
> >>         __le16 retval;
> >>         __le16 rsv;
> >>         __le32 data[6];
> >> };
> >>
> >> Casting __le32 to a pointer is wrong
> >>
> >> Jason
> >>
> > 
> > Hi Jason
> > 
> > desc.data is the address of array 'data[6]', it is got from the firmware, we
> > cast it to 'struct hns_roce_pf_func_info *' to parse its contents. I think this
> > is a cast from '__le32 *' to 'struct hns_roce_pf_func_info *'.
> > 
> > Thanks
> > Weihang
> > 
> > 
> 
> Jason, do you mean the current code is not written correctly? Do you have any
> suggestions for achieving our purpose?

Use a union

Jason
