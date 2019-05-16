Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCA1FDB6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 04:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfEPCVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 22:21:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:2362 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEPCVp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 22:21:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 19:21:44 -0700
X-ExtLoop1: 1
Received: from hanghang-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.137])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2019 19:21:37 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1hR61X-0006ww-Te; Thu, 16 May 2019 10:21:35 +0800
Date:   Thu, 16 May 2019 10:21:35 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "kbuild@01.org" <kbuild@01.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Message-ID: <20190516022135.6tnf3xx5mzctutxz@wfg-t540p.sh.intel.com>
References: <20190514194510.GA15465@archlinux-i9>
 <20190515003202.GA14522@ziepe.ca>
 <20190515050331.GC5225@mtr-leonro.mtl.com>
 <CAK8P3a0aH9Ezur3r7TDVMPreVKMip2HMEWhUsC_pKhOq7mE+3A@mail.gmail.com>
 <20190515064043.GA944@archlinux-i9>
 <CAK8P3a1r3QD=pwZqG+SfDkVr_V3P7ueRT8SLss9z+M6OEQst4A@mail.gmail.com>
 <20190515064918.GA4807@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190515064918.GA4807@archlinux-i9>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CC current 0day kbuild test maintainers Philip and Rong. -fengguang

On Tue, May 14, 2019 at 11:49:18PM -0700, Nathan Chancellor wrote:
>On Wed, May 15, 2019 at 08:42:13AM +0200, Arnd Bergmann wrote:
>> On Wed, May 15, 2019 at 8:40 AM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>> > On Wed, May 15, 2019 at 08:31:49AM +0200, Arnd Bergmann wrote:
>> > > On Wed, May 15, 2019 at 7:04 AM Leon Romanovsky <leonro@mellanox.com> wrote:
>> > > > On Tue, May 14, 2019 at 09:32:02PM -0300, Jason Gunthorpe wrote:
>> > > > > On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
>> > > > > > Hi all,
>> > > > > >
>> > > > > > I checked the RDMA mailing list and trees and I haven't seen this
>> > > > > > reported/fixed yet (forgive me if it has) but when building for arm32
>> > > > > > with multi_v7_defconfig and the following configs (distilled from
>> > > > > > allyesconfig):
>> > > > > >
>> > > > > > CONFIG_INFINIBAND=y
>> > > > > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
>> > > > > > CONFIG_INFINIBAND_USER_ACCESS=y
>> > > > > > CONFIG_MLX5_CORE=y
>> > > > > > CONFIG_MLX5_INFINIBAND=y
>> > > > > >
>> > > > > > The following link time errors occur:
>> > > > > >
>> > > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
>> > > > > > main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
>> > > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
>> > > > > > cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
>> > > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
>> > > > > > cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'
>> > > > >
>> > > > > Fengguang, I'm surprised that 0-day didn't report this earlier..
>> > > >
>> > > > I got many successful emails after I pushed this patch to 0-day testing.
>> > >
>> > > The long division warnings can compiler specific, and depend on certain
>> > > optimization options, as compilers can optimize out certain divisions and
>> > > replace them with multiplications and/or shifts, or prove that they can be
>> > > replaced with a 32-bit division. If this is a case that gcc manages to
>> > > optimize but clang does not, it might be worth looking into whether an
>> > > optimization can be added to clang, in addition to improving the source.
>> >
>> > While I did run initially run into this with clang, the errors above are
>> > with gcc (mainly to show this was going to be a universal problem and
>> > not just something with clang).
>>
>> Which gcc version did you use here? Anything particularly old or particularly
>> new? I think 0-day is on a fairly recent gcc-8, but not the latest gcc-9
>> release.
>
>8.2.0 it seems (I've been meaning to build from the 9.x branch though
>since it appears that Arch's arm-linux-gnueabi-gcc isn't going to get
>updated since it's in the AUR).
>
