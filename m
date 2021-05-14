Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4FC380C7F
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhENPDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 11:03:51 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:46305
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbhENPDv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 11:03:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiLreWQgk6RSv+k7WB4CNSrUlTpteuFIC3WgmQ6sFdKccv8pbeuOAfJ2A946yAIWJ8Mwod74z/kzp5SBni5J9xXbkzK3DteTxW0LdOTg5tiEKKe0jkjrFttPUR6AH+NepqXI2jo4OU4Z/gnHJ69Z55nT9gEviyUXDQ1IoCLtkQxy7EngJ7T2mV+zjreHQpyGXtG/mEK2IJeCL4yuVZRGOjc8fdCCNKScOEAKGN/7kn8OajctKbK9SGgNojg5lULoXd1yhq8HspT+6N4G83RUjR1XZsi6UeeTTVa9RVZaF/H8FQ1dPl3PoDAfQbhFR+dpdvbCie736PNunTB614hmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V8KiAjIxAp7cP6nOeM41LppPZREeAZFYp11vX2T8As=;
 b=O5AAEk/hOeQrxMRCh7dkUvh3Zql075X1K1MI+Rw43YnzsUMNM18t46STIOArGtPfhnNZKD292YVZhiXVsLz5+TKE9KSRjMBSUcs0yXCntb5lOA6KoGRVctwV//EJ6dKdb10VuHWwzYH3z5cBHDDQ2Bscc3RDal+hi9R5YfXGxfE81oHucCwojFyXpKtOyEN9GPD5VlGh/h1FCke8raoj0ktu66Y5gAPyqD75jnVBMR/+CAuZC0AV71e4wAOoGZSGYdaiYcQHStn/tz0xMX84lOjBlLj6XBNOqwwAT1CztxrylHSkh6PRdOGwIAR8rfqNsXjeDKH68N0ZYA3uSTjb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V8KiAjIxAp7cP6nOeM41LppPZREeAZFYp11vX2T8As=;
 b=ML3YH9KtEgfmzI2NQRWIDVbwIZVen4kAZcWqmZAJL5+pwy4eoVqH+UGBUStMbaOlp1raWKTGkULZFDn6ytsB5rtAwj+83M9mzoV7b8lUPk9WtIsabdohWCQCGghT9rL+iNkpGUiIQHR3T/qL6HGJYMMltS/vbAdK5uTWziGChqXLGfm3ufVH++BgvtMEbnFBaW+oxCEDGNfCaVGvvVimAS3YviV5m8mGRge/0kybubwRfztLSlCwqschy42OhzIHtNwRE1NkfFnPYN2SkLyHZ7eWwakDItpBPgscwpn3sJek3gMhhVoSl2ypk4LtGCS6jEkWENsGpYEnlRgD6CFIOA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 15:02:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 15:02:38 +0000
Date:   Fri, 14 May 2021 12:02:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210514150237.GJ1002214@nvidia.com>
References: <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:208:a8::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR12CA0032.namprd12.prod.outlook.com (2603:10b6:208:a8::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 15:02:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhZKn-007T9M-DK; Fri, 14 May 2021 12:02:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb64f0ca-e184-44f2-04eb-08d916e95083
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44020C3CB35E728FD79B4D49C2509@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSZNHDJ2u8fWgT61tj2NYXMp6j2G4rPaPkXtipUxFRwEWGe0HcfarRy+TjxrAKQx6MOlaKkRl9ilYILvSi1OuoPxrLTtXtd+mcK2osptdIfWLx1ZMczP7QQIdhhmYJ9VURhpCOWBjs+CkqQ/zQiJzkcavhfqzgarel3X55mZwXcOAepd8EfZUCjs9v+18MFjMLcU01rf+X1KmQRyD1Ga7unX0pX62uueFx5J/FNSAGklgIq9VqCvOkkok2Chm20QTp8GhGOZ94Eexg4DLYokdO/EGGtYBxvVeosgOMe2zgbt2+Xvicy6e6Ucf1zxHx6PGE4URApV4mMP38+WzWa43mjHzaBt450UTrcg6RaIf5GNQZo8EVqjfl4wsnoQbHEx+OXaqKGPHXI5F5soLa4cE0Bs5brbi1ynm2LViHV9H3VwXAntQlgvTtZvwAPJKn9cpoGe83KKbj3F2p7JZ/B1pfrcZuD0DhkJ10o+1wKej7JOLmJq6LMc782ftGHuITmJdgaDWNHY3tQeAxId9bSHzut1MNgd70Kq+l7ks3eTXpAXU2PwYM6Yz0rIr/OgvcIn8W+TOCQHRoryulS+WucyviOtMkSveiZBD9PF3MKTEnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(86362001)(5660300002)(66476007)(66946007)(66556008)(38100700002)(9786002)(9746002)(33656002)(478600001)(2616005)(6916009)(36756003)(8676002)(1076003)(316002)(26005)(4326008)(426003)(8936002)(2906002)(186003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/P0sQ8L/Pt0fexZ9JuvS9YkZNMpGCULOLIQz4f6HZAhAVM/0lc1455NhM7WJ?=
 =?us-ascii?Q?zsIVImEW04vGri+FNq1lEpGqdz05phEibeE8wucI6GLXDUsAuDDhmF2NwF3z?=
 =?us-ascii?Q?JvxoYtuH/xzML5BKRG/9hEAsT2/N6nu8DK+8IgyF8y0w3StWSy9Hn1E+c1gW?=
 =?us-ascii?Q?q/eCTLMmvkPnTl5PAJL5PvlUu/Ii7vh7Xza7HHGphRSmsALz54msowatLgB/?=
 =?us-ascii?Q?or2uS1MDWwyO1/lyyazBEFRGRqsxjrzFOyvGi244O07AlRikyGFMrLcWgaoj?=
 =?us-ascii?Q?TZPw54Ln0iU7ZknuTrpDUM/2LYm3n9rTNruV+Uz18564DL0uCe06rdQCXHP0?=
 =?us-ascii?Q?DcYLQ3/nn0a/iWV8ESn0QtPpc988hLFL8BHUjhLO5MS2+585DZ8Rn/QnnVCC?=
 =?us-ascii?Q?P3jjj3WycJ/OM1KDTkHuNtOQmt7YPsBk0MbB2b2mBdVp3UAtEL4wkcAOAMRB?=
 =?us-ascii?Q?Hj8Xear/xvN1VIS7dhgwk8yoOhk1riv4QYJldkS1mYVhscpneuG/qBxUPtZG?=
 =?us-ascii?Q?B1bCMjoaKGcsdBS5FHXpN6qzgklPhRzhMm0/uH8zAoYazSkO0oMJV7KftRu3?=
 =?us-ascii?Q?LlG4t499tQA5g8umRYmXr8gC2BUb10iYv6tcf3W4NZUhBDD1spNVku0aAso0?=
 =?us-ascii?Q?+hytgw/ILPlznTJpxEbXYzaLWwJzl+fPUp9InpNmgLgO0FQSIHlkGemw9ild?=
 =?us-ascii?Q?mlqr0QZZqboIl1bP16r6ipWwptNeKr7FPWNOUvQPet+s1o2iINpOrwR4GCwa?=
 =?us-ascii?Q?HOJCpehHJ2fyl0Ej2a80oOjvCVaeu7CMWFajo758LN96tOLgL1synaVWV9wD?=
 =?us-ascii?Q?MGcEmcU5TBmeCOYZ3T5sRvDG3HXprwcbq30NM5w+DYRJvrrMXAdbHBcui/MQ?=
 =?us-ascii?Q?wONlMYjoEWO9ENK+mFAHHx+XcN9+KeqHrgFZGJn3gDLZqsTWQ724oSn3x2mf?=
 =?us-ascii?Q?MfnNfM2XCm+Nn4SU9QVpwmyZVFzdsnCmJGMhqXFtDSMle51f2ZsPLhzd2yHC?=
 =?us-ascii?Q?sxY0xg9Z28/iC58musWR890Kh8zrOWL6h0ga/9d5Hexf9Ko69HJbiYEYJU62?=
 =?us-ascii?Q?Bb8zlPkDqYv++DQQjqRBaaZ5QWcjcx/riaykAuoyPqpZ6zlYqOtmbHKXyosj?=
 =?us-ascii?Q?MaI+A4WgLakO6uYRN5Iw3qIqYhZaNGy8g0zukkX1nvJb1TNlUFio/9Qa2Hss?=
 =?us-ascii?Q?C1ok60MThNOn6ZQO4dKBPTixKi2jiVfUG/XmwIxJI4VVnj5TpvnUkFcejrKl?=
 =?us-ascii?Q?GidFbbhABPjvty9X9xGV04Qy5emV8L80r2wQRCD6dXG7FajWcQEAjm8M9BKZ?=
 =?us-ascii?Q?SrG0YDFoWJpgLm0SH0HRqS2l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb64f0ca-e184-44f2-04eb-08d916e95083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 15:02:38.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfjYm86plCEGNJdIOasnyZr9YDz/oKWVFJX8aEiwiBbi7Y8IqSbAVaAmLpwWAO47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 03:00:37PM +0000, Marciniszyn, Mike wrote:
> > The core stuff in ib_qp is not performance sensitive and has no obvious node
> > affinity since it relates primarily to simple control stuff.
> > 
> 
> The current rvt_qp "inherits" from ib_qp, so the fields in the
> "control" stuff are performance critical especially for receive
> processing and have historically live in the same allocation.

This is why I said "core stuff in ib_qp" if drivers are adding
performance stuff to their own structs then that is the driver's
responsibility to handle.

> I would in no way call these fields "simple control stuff".  The
> rvt_qp structure is tuned to optimize receive processing and the
> NUMA locality is part of that tuning.
> 
> We could separate out the allocation, but that misses promoting
> fields from rvt_qp that may indeed be common into the core.
> 
> I know that we use the qpn from ib_qp and there may be other fields
> in the critical path.

I wouldn't worry about 32 bits when tuning for performance

Jason
