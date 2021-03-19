Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA734290B
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 00:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhCSXGv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 19:06:51 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:42401
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbhCSXGv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 19:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGer43jmxke6Rv5jIDWZIGt7UeqKKLGX1+CNNEGQLMLrqnIhyYdqySimNn8++Os934YygXnbaEOCm3fCxFQHuUsBwYoesh+vnppkCKxZ6r0It5vEPL7DhYqUtQp7f2tylx4Axn1964705w7ojRF5OteAnR7My7/4kXQlBH70UrC7CghA25ARsanW9yASlHAGEhTQ0Jzd4NJ1W7nFWbynkXdt/sRHvy9l7JbnqhvT28ggrcgH5KcC5uNFQ41Ow8DbK3xRBUnYkY2bmfOssB07t4OHKkQEpRIdn43+qG1cLgWJvqyFCylytv4xXGTIpxf8H7Ka5h81EBUnpu50nBzfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHMWLR3a1QIOpYfJ64o0ynhzaT6hWnJJbeFnN6tHk2A=;
 b=c5GwRzfn7ALiXfikgJfwJWdgOlkMGNrdb2+qpuHvfbi45Xn2IAZRxIqSV38fp2ObbkI+NAxdAmIKvAmV6neoiCEjYGndaiqJfKSGkq9SKuzUFAc51Ca96F3G0v+UnAlPbxRQT3q/DwVTs3j/3pDus1xbXPORX+PeTM5snB37fnvJg1FGstUJn9BJGFkPXwc8hVYXNGGIu/sDxAxToYagXwQK2/5EsvVMtNptqZi1QHObLMC5t0WODPnFrDfWNGCziQQFr6pJLshoo8TVDw8IUC/HPvSJLkdXhtwetEMZ7I/0JG3WcBFPzHv+GgJxtP92iKaEtx/zlvCS+IUORp/NwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHMWLR3a1QIOpYfJ64o0ynhzaT6hWnJJbeFnN6tHk2A=;
 b=p0tgUsYNr0c6xaIXCeGWvSw3G/CDh2QTVFYzEoMQZNQnjH/EkvtZDs025LADfZui9O8mHegJJOauy3qrBl4aqNM2QGdvUxMvOdiFY3VMHmL+D76lwlzsnwiWMbvXIGGQXGUOXbBj99yM8HSLZQqc1tnxqIWmz2dLguxPNirAXz78fXC9X8k396gqugidoR5KLO6GhsFHQf7DpSNI17BGlfbTac3nRWG0kXPusCilIOFcWyDxvxSsXtOR3Aa0zIDqvU57uYCSrCPdCV0joARNpY5jXBDkKnz+2BitQsZZKGhFFAw6fyFfAvO/TS9HFJMqJnBrX7pZfuP94bF0x7JmLg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 23:06:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 23:06:45 +0000
Date:   Fri, 19 Mar 2021 20:06:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319230644.GI2356281@nvidia.com>
References: <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:208:32a::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 23:06:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNOCa-00HUhH-4o; Fri, 19 Mar 2021 20:06:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 656a4409-110b-4ddd-983b-08d8eb2baad9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0106B3D517801A4E85A9F441C2689@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQc4KJBaZ7Np9ub/4e/CoKJ4x3i3QKedGOBkbK7OcoXInirlTT6VVMLpqlylBiZ3CSoYO7kpit0PDKLr9onI2PBzwx2dMfbQ3NjE8vRuZwIcoLzX4LQykOJ19AK5/pmttXvmU8WYlY232Ox/44BCzo8WCUQdtEf0xMMIxqjz9lXDDGewIzKsZGDSHRXC1UKqPqBpKA0cN0cEOe6K/To935rHadEdGkoOhA52QO5IeZkTtxk58zOQls4tZSK+dBZN8IIHd/AyS4BRj/22lnHqZ6uVlI7KTHJ8oMhr7QL6aEqHrjn8p3LsFsuttdW1ezMAylwatCpKo5NXw0g4JTg/uCa7BQgacBJjymAezxYMtUhV2M2pzRdZ7AOVxfpupc1NVvM3nVZ4cTGVrS0P0H1+fGKeHxVpxbEPf3zKpRzgqwZse6lyTYCTwdOl0lAxaofeSqRdcBvCt6WsfjsjvsYF32kEzitHZm+zDOd+d9pWnCxkjSaAZQnSSLx1IHHPdh2XIQE/YX6pqzDhBUbO9SVhOfQkUFEW0rEdlZLKzBgHCnCYOOgAmV1CrCV5ezxQ59437ZHaAetXPj+tNjukaMSh+u6yEBtR7afuenkV94GeAT74TJOuVywWfhnowC+liU/iWceUt9YQJ18Af8RrPhIJBI7ANMF6SzzSmVlXy8864kQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(26005)(9746002)(66556008)(8676002)(2616005)(8936002)(66946007)(426003)(6916009)(66476007)(86362001)(38100700001)(83380400001)(2906002)(36756003)(54906003)(33656002)(478600001)(1076003)(5660300002)(4326008)(316002)(186003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nKhXkrqtvUVqzFRs3H8gtV8kB97bnV+TFYxC5b7mzH4F7QV3A0esUZNCYODz?=
 =?us-ascii?Q?PvZxmVdPe/Ft3FEOLoHf0KtTMzrVjQn2YYcCeC3ToznSeX10kJ9pjDqYV96V?=
 =?us-ascii?Q?shsoaiJmu7L7yvRWIeG2lxxXrOL+MjX1hMoFts18VllHHO9btu2UncACFJ6Q?=
 =?us-ascii?Q?/KIcESBcJ/1rlF9j+POrF1fKuRrc3Y2R9cd9FdYF560+2utqzbwzKGa1rs+o?=
 =?us-ascii?Q?yGoEvaXMYm6KvhYHeNXy6vdFX5E8YP1Mbfxv8bzwEw7Zcg9gK7QnICwQulvd?=
 =?us-ascii?Q?9sXXJGH9IsNGjs5Uttob2CzEx448rHt8F087pnhO/+sm6YD/eDLEk/brZZFP?=
 =?us-ascii?Q?LgvecNTRld/RX0418GUm6X5fi8tOuLcCdCJjjyzpxqju+1dCyWIWnOj0jGW7?=
 =?us-ascii?Q?AHZAO1fCrAs5nw7JNt4JathjH2ptrvKHh9S7QFIphExYHhZB+5SwITrkcWXv?=
 =?us-ascii?Q?KjnHihcPQ88c3PFZpjfRpIwVMX5sZXjzFM5TPxLA9kathe0VBp2pmkZg1Z9J?=
 =?us-ascii?Q?XMUcsVG3UcHKWDbXtfb5WWycLsFvGp/g34hv5V0BIw4bl6fP426OFQJHDvgv?=
 =?us-ascii?Q?V2c8rQm/uBrCTKTaZ+vT+0sNqCOQO3kkwvrkJDZGAXtB4pfQueuFfFSq3hzk?=
 =?us-ascii?Q?XRg5z7brKfMT4z/9gZezUv/JiClf0IfyI6CkQ5oCl/C7JT7/fwWEZ1cX42TJ?=
 =?us-ascii?Q?XfmZ6Dt6XMhaOC1yN+ZAL9WAS+MzEbYlYlXDO1Pixjqn2VJ73lXFoaKDFq1K?=
 =?us-ascii?Q?89TMCTjvsc1JHUXlfZxE+C+MrY4OdsGbJ49Yj9pk2uOCPDbx7tFH68xlmmzd?=
 =?us-ascii?Q?MUo6C7B9aSvzzuiRIx3aqbXvaeYOkMGxYoXf8XGh1wN/yc6YwLsBm4o8Le27?=
 =?us-ascii?Q?dk/emB/PilIis27ExbVag0w5RrCvrlx4KXdVA429tdc5dpjcDzFPWJdQFJvG?=
 =?us-ascii?Q?ZKFVKhFVZ9XR00H1vYouNcJfUbkSB+BMyB96bb5dZ63NKMxtC6qBn6cCKjyJ?=
 =?us-ascii?Q?OcCEy6M7n6T5wSX0wSpuSGVgjvVi/yK3vvOXi/kvBCoZ4qqviuOMIWhCUMQ4?=
 =?us-ascii?Q?G92GO/l+Ve7IFimU0cKBODdd5Z8OwmvP/Z8MGxnKAp3RWY8UaIdMgW860wrK?=
 =?us-ascii?Q?AJpK/avM/lHaHj4lJVymB0jDvXcrrrD7kIp61BmosAhnFpr1zHVJkDfppfeC?=
 =?us-ascii?Q?06xh+jpUD0epcIB2jY3DNxA8Ru412gbBhYe2eD/tf9YtA69pf7BliiSwzfiu?=
 =?us-ascii?Q?s0rapT2S87ie2E7Js18pCFPfDXWq+YvC13POMbYmhCekufuP0db1PieUlRO1?=
 =?us-ascii?Q?x8iTJvN4gBfQPK9LLpWhF5DpC0vUqJwo5HDLH77+3cqk0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656a4409-110b-4ddd-983b-08d8eb2baad9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 23:06:45.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjIMoZAhj69VqOSS7dHjO925EZpmDP5L2ZwtvtTazTvXqKMBiwJOjRzjP1gTVQqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 10:57:20PM +0000, Rimmer, Todd wrote:

> We'd like advise on a challenging situation.  Some customers desire
> NICs to support nVidia GPUs in some environments. Unfortunately the
> nVidia GPU drivers are not upstream, and have not been for years.

Yep.

> So we are forced to have both out of tree and upstream versions of
> the code.

Sure

>  We need the same applications to be able to work over
> both, so we would like the GPU enabled versions of the code to have
> the same ABI as the upstream code as this greatly simplifies things.

The only answer is to get it upstream past community review before you
ship anything to customers.

> We have removed all GPU specific code from the upstream submission,
> but used both the "alignment holes" and the "reserved" mechanisms to
> hold places for GPU specific fields which can't be upstreamed.

Sorry, nope, you have to do something else. We will *not* have garbage
in upstream or be restricted in any way based on out of tree code.

Jason
