Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625D25AF2C5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Sep 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiIFRhq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIFRhD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 13:37:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43253CBD9
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 10:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhxtDZWTu1LXQ8bE4BfQG29LtYW/CcZvOvrpBi1FGE9HLP2ABoYP9/WoDyAgU6wiRRsVfzdDD9AzTNY+euyMzHaEgd8hPKrk6PnQtTBpcuOUdw6XSN/r3Uv7+FCnQAyE+FP0NxBPBVnS2Q6evXjjduRcLjy/PEcg4Mrmzw/Njt9ZLD9ODq/Ulim+mHkdL5oFA97mF0FC+OPOKJ47Y0QQxaL7iufW9t2sNktfTa1NRV9Iw5IxURQYALD+hysUmz/O612iWXGs2FnldHS8ub+zGcX4qAHO43ktRkNd99UkuBWAc2Dfi/+dvEdW6KWWgH3LFaZSoYj3Bvb3FhYXbzSdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJAaeKQKNpo/P1v3BcYOO6IXbujqeQ4AxXXTQOtyhbA=;
 b=Zg+DPLrFzk9etAQdCfQmxvm2BKSW03EMyGT5PDU2xsmwf3nVptVFikEoMg1JAZfn9EYGMB1vNd25wRnazo+r/h8x+Uy5phWR6M9bwbrmekCVCQUh8/OderSKZEyuJU/GvZwABZD5tnnlYpuh9hZohW8u8jHbazlVDJ2u84M3yAK7mjIuXJ6ANr1XVdH6D5dy70Q+wZu3LqeCED8Jyqlzy4xE7uN+9efFZ/wbbxoZLSzjB+SDVj4WLfJ6or+i/wFTS99WPHPlqYrmExSujg7ATwK+7yPLlVqzaUojubq9VrSyxlsXFG5NnGwc3AmXvRjiMCyCZMF/UxYqcgW4QeVR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJAaeKQKNpo/P1v3BcYOO6IXbujqeQ4AxXXTQOtyhbA=;
 b=tjpNTFptoZRvndOO9tyRT+DTRAcjGdtqJ/S8N0WHtxez14Iow7rOR2G4+H7jW0e92ZTznlpCZ2VuGLOWbgzAcOiZ7rR4QnUJzVB2ZeblUnWZ/tTpcOil8ZsNWmJchQeyIIOZATRvrmO3h6x8zAeVrYN4Ph+kSzv4q82Rn+AP+5MSka5yi5UQHwpwOpnmzrDpkSK+f77YKK3Wx6T6FtbcuWy0GE3T4zHoZh4dQqswiRV/OWKSoe9iOqlQ0PBICyJ0NjI7G3YVADxYpOu+aZQrK/PjeKJL6MkWisL9VMF4VofouXNVx+W6PqpfEnhhlD8zq1WgWiUkDdFjkGiwKPCz3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 17:33:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 17:33:20 +0000
Date:   Tue, 6 Sep 2022 14:33:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for
 boundary condition
Message-ID: <YxeEX7XcwYpnbP3M@nvidia.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com>
 <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
 <Yv94fYp8869XZKFU@nvidia.com>
 <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
 <YwjHSBr3f4o0hXBX@nvidia.com>
 <85a37f42a08f4163cb5440d8825b7e7a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a37f42a08f4163cb5440d8825b7e7a@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b4dd321-528b-4f91-95ca-08da902de3f7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5970:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVW5Oa1cBg8AffVh/arOrcxxJJfjRLvBbSW46c84Mnc5wwY+a0RVe2eCiO+3UOAyJgK/6AnaO0Xjel3ZglJR9FC6ygJ3GTfVrKIvOGggT33dZnQpokSM1iTm/dUbbVcaKLHfCtqbD8Y6NIkTSdA1kRROEoiQrm1uwbg/9LkCphOR81nj7ii+8VPfelFY44oK6D8R6vYol+A/7mzifPh/bmKixNdUjfrXZEDa+AMsP2lw1YiM5N5XZxAqIYQW10RfxSkY7yILRvjjvxYAiO6P7TT4NsHtEuyKTgcYNB5VFV2c73e48V44DvxVjH4bK9gL90bAaU6iqWZ0eplR7d4nJJ4KzjG+7lxx+mZuBr7eKYpROlfB546zPbMDZwkcsmqu0hyNmzCvEEFT0Pnd/1t6a3KPKEa43Zin7KrI0Bzn3Q5GE5FpMmKPAtrA1sSiQJzrO8kerj/WQKDrG5wqrIERI2IvLljNt2llWHco46qeeCgriFgrFvPibzFbjm9faPxUgQHaNt8CSNhog1bdyiPCiTksfHe7toIZLbFwpjn7/x2odg1Sw5eRt6HQBpEwPR0xqsuDJ5SgePx/YnGx+IFRuBHzKKbCi8up3psJHj56IwhXRLVWkyM0vq90qaIvcSwBrwk/xNLOiPj67zGjcEuNH8F6T2RUSOX1nlF9hMNCqhSFcYV0pKsV847CIBD8Fvypl0ZkM+cxWZE1dw6SRrjvkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(478600001)(2616005)(186003)(66946007)(83380400001)(4326008)(8676002)(66556008)(66476007)(6506007)(36756003)(41300700001)(26005)(53546011)(6486002)(6512007)(86362001)(54906003)(8936002)(5660300002)(2906002)(6916009)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4/2cMlUgHFpzw3o/wmsXHiUg0DHXZ5Q1cVoMOP3zdA5xU3yYUg5tyA7kV9cw?=
 =?us-ascii?Q?e7kKbhPC0svPCL0kcqr46LW+ffzzilCmMK3Ip+dHrTScsbnrnf9qyNyFEm5u?=
 =?us-ascii?Q?/WXVp83GX7Aa1fn/gpuFuLKVyXrrOe81nEdgZbOeQz6iPxbwIHvtC26DMnJI?=
 =?us-ascii?Q?yXrWU08ZsGW/T/7EjQGZDTI7xpLKi2l5JP6dMQkebA4umf6rmKJYESV9zy2t?=
 =?us-ascii?Q?9L3UqQD4Vb7ST6TfOIeVKs06GOApn5yPvlSaXINAgTy+c/bor+ikA8vGbXuC?=
 =?us-ascii?Q?zAaWv7yF2hC1emaPj4KlI26h5AslY6MPdKSY87XD5+C3pRUqzUr17yXa8NJz?=
 =?us-ascii?Q?Sq4Uz2aIjH1Unzrs+iqKhGlGzJPJHnZMdoTSDXnODqE82U8RQUxMX2eSQFKt?=
 =?us-ascii?Q?aYUsZLDtBL37pC1Y4Okc73ROxn8Fj+DauZiGzYu5ILt71aQ91rLgTZn7GcSE?=
 =?us-ascii?Q?xRoAYARFawRsGQepFxFwrupSa8Cx7nMAreBkjAqMl50Xswh4/AfUo8PlhLqI?=
 =?us-ascii?Q?1oHGa9/0bB7OHndZVqbZcm9KYJUogIG6U44D16bcyDo5AioyqbziHMcylwXr?=
 =?us-ascii?Q?jphtuVVS7Eds91RL674jWuoRDBrQaOWvT94yypDJOuZqmWvZtC4ml3JEpnrT?=
 =?us-ascii?Q?h/TtkGirv1xkExR3phWvhgANo1IVvFav4TY2tqLRk8VhxJALa+s4bPHHcXJQ?=
 =?us-ascii?Q?UXBQEuo7G1rpj4fV2+jOE/HHw368c0tYb8m2qWzavEoWxroKNjAXwccHya4N?=
 =?us-ascii?Q?robrsSxP70QOeT+lEjbam8YoHHwaEBLDuoSLItAC453MB6ZilFFYeZU7+Kju?=
 =?us-ascii?Q?uoNsqdO07XJBvpmu4vq4fZSxrgPbKyiD3Br7b/JFvhzbflkxrvMKwx+tbJK6?=
 =?us-ascii?Q?s9DuIc8BQja7J95D86qlgUO9/OYKNz2CtKJuhlGKdiMFqnHPQQf86SIL22gi?=
 =?us-ascii?Q?fsMjn0PHlClMklOsK1YAPf/AslSuZpKlURSagO7P5rjhdNbkTBeN1Do7UAj7?=
 =?us-ascii?Q?ryq8++G0QKtBBFsDBt01M0gBh3Tmu7QS5qZKEiib0neBB+AZUrKRViZyD6xq?=
 =?us-ascii?Q?vLDekaacWpCo94d4Y1dLmrtv3wGHvgnz3WUEPzDpVp1W3oZGal+W6f99gD5o?=
 =?us-ascii?Q?+6HIT5gYDWjpDbAov1mNIkuM2yQdvpSk3QNKi2wSsFqR5/NDfaDXsqrp5Q6Z?=
 =?us-ascii?Q?7jRwxquW+XM0zkGlyFGYXRpixC3mtNiRHZobQmb0RjhakJVqlUT0u/xCSVK/?=
 =?us-ascii?Q?DVTBra/0ELYhEf4Sz6AajdMB918b4ao04w5ngZBZFGQPTdqMAPgPID6+HAAd?=
 =?us-ascii?Q?JE83KcniBxsSLzYPcNQd2ZPXkZxsV+fwrLzo546RpAtcTWQ4T8rHhmlsNVdI?=
 =?us-ascii?Q?pmxLPb/a2OivKheAkBnGahU5lGxrTLdOV53XvAWx+5/jGWN/BrONN0H1UR9N?=
 =?us-ascii?Q?HzABl7ekM5K5X+3JWgG4ZJF/t/uctl8VmEdKUMBimHGYkTcXGV/2Aru+S7aN?=
 =?us-ascii?Q?ZpnGOkgudOyQgoJLjuuQnMF77v0FQiyNRC2pl0/5t2litOc0P0RSc1qZSRKp?=
 =?us-ascii?Q?IcafcK2nkEMiuclMe0OsEd6o3RGsY3wI4yUOmSmN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4dd321-528b-4f91-95ca-08da902de3f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 17:33:20.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AtEwayUSsr7DEFJnEH1WbG8kkEEYANmTPxudMU/U6bIN17/q19JP+vT96xDRT9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 05:36:57PM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: Friday, August 26, 2022 6:45 PM
> > To: Kashyap Desai <kashyap.desai@broadcom.com>
> > Cc: linux-rdma@vger.kernel.org; leonro@nvidia.com; Selvin Xavier
> > <selvin.xavier@broadcom.com>; Andrew Gospodarek
> > <andrew.gospodarek@broadcom.com>
> > Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for
> > boundary condition
> >
> > On Mon, Aug 22, 2022 at 07:51:22PM +0530, Kashyap Desai wrote:
> >
> > > Now, we will enter into below loop with dma_addr = page_addr =
> > > 0xffffffffffffe000 and "end_dma_addr = dma_addr + dma_len" is ZERO.
> > > eval 0xffffffffffffe000 + 8192
> > > hexadecimal: 0
> >
> > This is called overflow.
> 
> Is this not DMAable for 64bit DMA mask device ? It is DMAable. So not sure
> why you call it as overflow. ?

Beacuse the normal math overflowed.

Should it work? Yes. Is it a special edge case that might have bugs?
Certainly.

So the IOMMU layer shouldn't be stressing this edge case at all. It is
crazy, there is no reason to do this.

> I agree that such mapping is obviously dangerous, but it is not illegal as
> well.
> Same sgl mapping works if it is direct attached Storage, so there will be
> a logical question why IB stack is not handling this.

Oh that is probably very driver dependent.

> > You need to write the code so you never create the situation where
> > A+B=0 - don't try to fix things up after that happens.
> 
> In proposed patch, A + B = 0 is possible, but it will be considered as end
> of the loop.

Like I said, don't do that. End of the loop is -1 which requires a
different loop logic design, so send a patch like that.

But I would still send a patch for iommu to not create this in the
first place.

Jason
