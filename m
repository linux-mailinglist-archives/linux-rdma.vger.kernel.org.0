Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB77D13E1A
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEEHOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 03:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfEEHOm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 03:14:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A502087F;
        Sun,  5 May 2019 07:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557040481;
        bh=wfOufAim4Z05zwv37oknpoe8Q7ERn1v/x1yShXBuzwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEPSKJZFVOtrHxerAwWDvAcODpxmsrEiPojp4/7M+6j0blyCN6MVehJ4myZtrIC5X
         34/Zr3ouf0/msOtEJgUzm/YP2V9vUOt0UB2m+ZIjJ46Mn0DhmkOHtLOugSTpCQdchY
         m6ed6oVQKxlrUjcHhFrZAOOMC8hJMNSequou6LUI=
Date:   Sun, 5 May 2019 10:14:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Welty, Brian" <brian.welty@intel.com>
Cc:     Kenny Ho <y2kenny@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Parav Pandit <parav@mellanox.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        J??r??me Glisse <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Christian K??nig <christian.koenig@amd.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        kenny.ho@amd.com, Harish.Kasiviswanathan@amd.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
Message-ID: <20190505071436.GD6938@mtr-leonro.mtl.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
 <20190502083433.GP7676@mtr-leonro.mtl.com>
 <CAOWid-cYknxeTQvP9vQf3-i3Cpux+bs7uBs7_o-YMFjVCo19bg@mail.gmail.com>
 <bb001de0-e4e5-6b3f-7ced-9d0fb329635b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb001de0-e4e5-6b3f-7ced-9d0fb329635b@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 02:14:33PM -0700, Welty, Brian wrote:
>
> On 5/2/2019 3:48 PM, Kenny Ho wrote:
> > On 5/2/2019 1:34 AM, Leon Romanovsky wrote:
> >> Count us (Mellanox) too, our RDMA devices are exposing special and
> >> limited in size device memory to the users and we would like to provide
> >> an option to use cgroup to control its exposure.
>
> Hi Leon, great to hear and happy to work with you and RDMA community
> to shape this framework for use by RDMA devices as well.  The intent
> was to support more than GPU devices.
>
> Incidentally, I also wanted to ask about the rdma cgroup controller
> and if there is interest in updating the device registration implemented
> in that controller.  It could use the cgroup_device_register() that is
> proposed here.   But this is perhaps future work, so can discuss separately.

I'll try to take a look later this week.

>
>
> > Doesn't RDMA already has a separate cgroup?  Why not implement it there?
> >
>
> Hi Kenny, I can't answer for Leon, but I'm hopeful he agrees with rationale
> I gave in the cover letter.  Namely, to implement in rdma controller, would
> mean duplicating existing memcg controls there.

Exactly, I didn't feel comfortable to add notion of "device memory"
to RDMA cgroup and postponed that decision to later point of time.
RDMA operates with verbs objects and all our user space API is based around
that concept. At the end, system administrator will have hard time to
understand the differences between memcg and RDMA memory.

>
> Is AMD interested in collaborating to help shape this framework?
> It is intended to be device-neutral, so could be leveraged by various
> types of devices.
> If you have an alternative solution well underway, then maybe
> we can work together to merge our efforts into one.
> In the end, the DRM community is best served with common solution.
>
>
> >
> >>> and with future work, we could extend to:
> >>> *  track and control share of GPU time (reuse of cpu/cpuacct)
> >>> *  apply mask of allowed execution engines (reuse of cpusets)
> >>>
> >>> Instead of introducing a new cgroup subsystem for GPU devices, a new
> >>> framework is proposed to allow devices to register with existing cgroup
> >>> controllers, which creates per-device cgroup_subsys_state within the
> >>> cgroup.  This gives device drivers their own private cgroup controls
> >>> (such as memory limits or other parameters) to be applied to device
> >>> resources instead of host system resources.
> >>> Device drivers (GPU or other) are then able to reuse the existing cgroup
> >>> controls, instead of inventing similar ones.
> >>>
> >>> Per-device controls would be exposed in cgroup filesystem as:
> >>>     mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/<subsys_files>
> >>> such as (for example):
> >>>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
> >>>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
> >>>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat
> >>>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.weight
> >>>
> >>> The drm/i915 patch in this series is based on top of other RFC work [1]
> >>> for i915 device memory support.
> >>>
> >>> AMD [2] and Intel [3] have proposed related work in this area within the
> >>> last few years, listed below as reference.  This new RFC reuses existing
> >>> cgroup controllers and takes a different approach than prior work.
> >>>
> >>> Finally, some potential discussion points for this series:
> >>> * merge proposed <subsys_name>.devices into a single devices directory?
> >>> * allow devices to have multiple registrations for subsets of resources?
> >>> * document a 'common charging policy' for device drivers to follow?
> >>>
> >>> [1] https://patchwork.freedesktop.org/series/56683/
> >>> [2] https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> >>> [3] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html
> >>>
> >>>
> >>> Brian Welty (5):
> >>>   cgroup: Add cgroup_subsys per-device registration framework
> >>>   cgroup: Change kernfs_node for directories to store
> >>>     cgroup_subsys_state
> >>>   memcg: Add per-device support to memory cgroup subsystem
> >>>   drm: Add memory cgroup registration and DRIVER_CGROUPS feature bit
> >>>   drm/i915: Use memory cgroup for enforcing device memory limit
> >>>
> >>>  drivers/gpu/drm/drm_drv.c                  |  12 +
> >>>  drivers/gpu/drm/drm_gem.c                  |   7 +
> >>>  drivers/gpu/drm/i915/i915_drv.c            |   2 +-
> >>>  drivers/gpu/drm/i915/intel_memory_region.c |  24 +-
> >>>  include/drm/drm_device.h                   |   3 +
> >>>  include/drm/drm_drv.h                      |   8 +
> >>>  include/drm/drm_gem.h                      |  11 +
> >>>  include/linux/cgroup-defs.h                |  28 ++
> >>>  include/linux/cgroup.h                     |   3 +
> >>>  include/linux/memcontrol.h                 |  10 +
> >>>  kernel/cgroup/cgroup-v1.c                  |  10 +-
> >>>  kernel/cgroup/cgroup.c                     | 310 ++++++++++++++++++---
> >>>  mm/memcontrol.c                            | 183 +++++++++++-
> >>>  13 files changed, 552 insertions(+), 59 deletions(-)
> >>>
> >>> --
> >>> 2.21.0
> >>>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
