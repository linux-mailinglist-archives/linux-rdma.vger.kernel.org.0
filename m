Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C8198180
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgC3Qnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 12:43:46 -0400
Received: from mx.sdf.org ([205.166.94.20]:61397 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgC3Qnq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Mar 2020 12:43:46 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02UGhY7M005414
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 16:43:34 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02UGhXPV013082;
        Mon, 30 Mar 2020 16:43:33 GMT
Date:   Mon, 30 Mar 2020 16:43:33 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org, lkml@sdf.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200330164333.GB2459@SDF.ORG>
References: <202003281643.02SGh6eG002694@sdf.org>
 <20200329141710.GE20941@ziepe.ca>
 <20200329160825.GA4675@SDF.ORG>
 <20200330132808.GB20969@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330132808.GB20969@lakrids.cambridge.arm.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 30, 2020 at 02:28:08PM +0100, Mark Rutland wrote:
> Also, if you do send a series, *please* add a cover-letter explaining
> what the overall purpose of the series is, and have all patches chained
> in-reply-to that rather than patch 1. Otherwise reviewers have to
> reverse-engineer the intent of the author.
> 
> You can generate the cover letter with:
> 
> $ git format-patch --cover $FROM..$TO
> 
> ... and IIRC git send-email does the right thing by default if you hand
> it all of the patches at once.

Er, I *did* send a cover letter.  Cc:ed to the union of everyone
Cc:ed on any of the individual patches.  It's appended.  (I left in
the full Cc: list so you can see you're on it.)

My problem is I don't have git on my e-mail machine, so I fed them to 
sendmail manually, and that does some strange things.

From 0ca5529c065d9ec469c90ae56955386c91d0bced Mon Sep 17 00:00:00 2001
From: George Spelvin <lkml@sdf.org>
Date: Thu, 26 Mar 2020 08:21:04 -0400
Subject: [RFC PATCH v1 00/52] Audit kernel random number use
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, lkml@sdf.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
    "Darrick J. Wong" <darrick.wong@oracle.com>,
    "David S. Miller" <davem@davemloft.net>,
    "J. Bruce Fields" <bfields@fieldses.org>,
    "Theodore Ts'o" <tytso@mit.edu>,
    Adrian Hunter <adrian.hunter@intel.com>,
    Akinobu Mita <akinobu.mita@gmail.com>,
    Alexei Starovoitov <ast@kernel.org>,
    Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
    Andreas Dilger <adilger.kernel@dilger.ca>,
    Andrew Morton <akpm@linux-foundation.org>,
    Andrii Nakryiko <andriin@fb.com>,
    Andy Lutomirski <luto@kernel.org>,
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
    Anna Schumaker <anna.schumaker@netapp.com>,
    Anton Blanchard <anton@samba.org>,
    Antonio Quartulli <a@unstable.cc>,
    Ard Biesheuvel <ard.biesheuvel@linaro.org>,
    Arend van Spriel <arend.vanspriel@broadcom.com>,
    Artem Bityutskiy <dedekind1@gmail.com>,
    Aruna-Hewapathirane <aruna.hewapathirane@gmail.com>,
    Bart Van Assche <bvanassche@acm.org>,
    Benjamin Herrenschmidt <benh@kernel.crashing.org>,
    Benjamin Tissoires <benjamin.tissoires@redhat.com>,
    Bernard Metzler <bmt@zurich.ibm.com>,
    Borislav Petkov <bp@alien8.de>,
    Brian Norris <computersforpeace@gmail.com>,
    Catalin Marinas <catalin.marinas@arm.com>,
    Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
    Chris Leech <cleech@redhat.com>,
    Chris Wilson <chris@chris-wilson.co.uk>,
    Chris Zankel <chris@zankel.net>,
    Christian Borntraeger <borntraeger@de.ibm.com>,
    Christian Lamparter <chunkeey@gmail.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Cong Wang <xiyou.wangcong@gmail.com>,
    Dan Williams <dan.j.williams@intel.com>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Dave Hansen <dave.hansen@linux.intel.com>,
    David Woodhouse <dwmw2@infradead.org>,
    Davidlohr Bueso <dave@stgolabs.net>,
    Dennis Dalessandro <dennis.dalessandro@intel.com>,
    Dmitry Safonov <0x7f454c46@gmail.com>,
    Doug Ledford <dledford@redhat.com>,
    Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
    Eric Biggers <ebiggers@google.com>,
    Eric Dumazet <eric.dumazet@gmail.com>,
    Faisal Latif <faisal.latif@intel.com>,
    Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
    Franky Lin <franky.lin@broadcom.com>,
    Hannes Frederic Sowa <hannes@stressinduktion.org>,
    Hannes Reinecke <hare@suse.de>,
    Hans de Goede <hdegoede@redhat.com>,
    Hante Meuleman <hante.meuleman@broadcom.com>,
    Heiko Carstens <heiko.carstens@de.ibm.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
    Hsin-Yi Wang <hsinyi@chromium.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Ingo Molnar <mingo@kernel.org>,
    Intel Linux Wireless <linuxwifi@intel.com>,
    Jamal Hadi Salim <jhs@mojatatu.com>,
    James Hogan <jhogan@kernel.org>,
    Jan Kara <jack@suse.com>,
    Jani Nikula <jani.nikula@linux.intel.com>,
    Jaroslav Kysela <perex@perex.cz>,
    Jason A. Donenfeld <Jason@zx2c4.com>,
    Jason Gunthorpe <jgg@ziepe.ca>,
    Jeff Layton <jlayton@kernel.org>,
    Jiri Kosina <jkosina@suse.cz>,
    Jiri Pirko <jiri@resnulli.us>,
    Joel Becker <jlbec@evilplan.org>,
    Johan Hovold <johan@kernel.org>,
    Johannes Berg <johannes.berg@intel.com>,
    Johannes Berg <johannes@sipsolutions.net>,
    Jon Maloy <jon.maloy@ericsson.com>,
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
    Joseph Qi <joseph.qi@linux.alibaba.com>,
    Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
    Kalle Valo <kvalo@codeaurora.org>,
    Karsten Keil <isdn@linux-pingi.de>,
    Kees Cook <keescook@chromium.org>,
    Lars Ellenberg <lars.ellenberg@linbit.com>,
    Lee Duncan <lduncan@suse.com>,
    Luca Coelho <luciano.coelho@intel.com>,
    Maciej Zenczykowski <maze@google.com>,
    Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
    Marek Lindner <mareklindner@neomailbox.ch>,
    Marek Vasut <marek.vasut@gmail.com>,
    Mark Fasheh <mark@fasheh.com>,
    Martin Hundeboll <martin@hundeboll.net>,
    Martin KaFai Lau <kafai@fb.com>,
    Max Filippov <jcmvbkbc@gmail.com>,
    Mel Gorman <mgorman@suse.de>,
    Michael Ellerman <mpe@ellerman.id.au>,
    Michal Hocko <mhocko@suse.com>,
    Mike Marciniszyn <mike.marciniszyn@intel.com>,
    Miquel Raynal <miquel.raynal@bootlin.com>,
    Neil Horman <nhorman@tuxdriver.com>,
    Nicholas Bellinger <nab@linux-iscsi.org>,
    Paul Burton <paulburton@kernel.org>,
    Paul Mackerras <paulus@samba.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Philipp Reisner <philipp.reisner@linbit.com>,
    Potnuri Bharat Teja <bharat@chelsio.com>,
    QLogic-Storage-Upstream@cavium.com,
    Qian Cai <cai@lca.pw>,
    Ralf Baechle <ralf@linux-mips.org>,
    Rich Felker <dalias@libc.org>,
    Richard Weinberger <richard@nod.at>,
    Rodrigo Vivi <rodrigo.vivi@intel.com>,
    Roman Gushchin <guro@fb.com>,
    Russell King <linux@armlinux.org.uk>,
    Sage Weil <sage@redhat.com>,
    Samuel Ortiz <sameo@linux.intel.com>,
    Santosh Shilimkar <santosh.shilimkar@oracle.com>,
    Sean Rees <sean@erifax.org>,
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
    Shiraz Saleem <shiraz.saleem@intel.com>,
    Simon Wood <simon@mungewell.org>,
    Simon Wunderlich <sw@simonwunderlich.de>,
    Song Liu <songliubraving@fb.com>,
    Steffen Klassert <steffen.klassert@secunet.com>,
    Stephen Hemminger <stephen@networkplumber.org>,
    Sven Eckelmann <sven@narfation.org>,
    Takashi Iwai <tiwai@suse.com>,
    Thomas Garnier <thgarnie@chromium.org>,
    Thomas Garnier <thgarnie@google.com>,
    Thomas Gleixner <tglx@linutronix.de>,
    Thomas Hellstrom <thellstrom@vmware.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Uladzislau Rezki (Sony) <urezki@gmail.com>,
    Ulf Hansson <ulf.hansson@linaro.org>,
    Vasily Gorbik <gor@linux.ibm.com>,
    Vignesh Raghavendra <vigneshr@ti.com>,
    Vitaly Kuznetsov <vkuznets@redhat.com>,
    Vlad Yasevich <vyasevich@gmail.com>,
    Will Deacon <will@kernel.org>,
    Wright Feng <wright.feng@cypress.com>,
    Ying Xue <ying.xue@windriver.com>,
    Yonghong Song <yhs@fb.com>,
    Yoshinori Sato <ysato@users.sourceforge.jp>,
    Yu Zhao <yuzhao@google.com>,
    alsa-devel@alsa-project.org,
    bpf@vger.kernel.org,
    brcm80211-dev-list.pdl@broadcom.com,
    brcm80211-dev-list@cypress.com,
    ceph-devel@vger.kernel.org,
    intel-gfx@lists.freedesktop.org,
    isdn4linux@listserv.isdn4linux.de,
    linux-arm-kernel@lists.infradead.org,
    linux-crypto@vger.kernel.org,
    linux-ext4@vger.kernel.org,
    linux-mips@vger.kernel.org,
    linux-mm@kvack.org,
    linux-mmc@vger.kernel.org,
    linux-mtd@lists.infradead.org,
    linux-nfc@lists.01.org,
    linux-nfs@vger.kernel.org,
    linux-rdma@vger.kernel.org,
    linux-s390@vger.kernel.org,
    linux-scsi@vger.kernel.org,
    linux-sctp@vger.kernel.org,
    linux-sh@vger.kernel.org,
    linux-wireless@vger.kernel.org,
    linux-xfs@vger.kernel.org,
    linux-xtensa@linux-xtensa.org,
    linuxppc-dev@lists.ozlabs.org,
    netdev@vger.kernel.org,
    netem@lists.linux-foundation.org,
    ocfs2-devel@oss.oracle.com,
    rds-devel@oss.oracle.com,
    tipc-discussion@lists.sourceforge.net,
    x86@kernel.org

Sorry for the long Cc list, but this is a treewide cleanup and
I wanted to send this cover letter to everyone.  Individual patches
are Cc: the relevant maintainers, and the whole series can be found
on linux-kernel@vger.

The original itch I wanted to scratch was fixing the numerous
instances of "get_random_u32() % range" and "prandom_u32() % range"
in the kernel.  % is fast to type but slow to execute: even in the
optimized special case that the range is a compile-time constant,
the modulo requires two multiplies to evaluate.

prandom_u32_max() works better; it used reciprocal_scale(), which
ends up doing (u64)prandom_u32() * range >> 32".

This is not only faster and less code, the random numbers are
more uniform.  When the range is not a power of 2, some outputs are
generated more often than others.  With the modulo technique, those
are all the outputs less than 0x100000000 % range.  When multiplying,
the overrepresented outputs are at least spread uniformly across the
possible outputs.

The multiplicative technique can also be easily extended to
generate perfectly uniform random numbers (by detecting an
overrepresented case and looping if it happens) if desired.


But as I started in on the project, I kept finding more things
that needed fixing.  This patch series is what I have ready at the moment.

I could use feedback on individual patches, but also the series as
a whole.  How should it be broken up?  How should it be submitted?

Perhaps, with this series as motivation, merge the random.[ch]
changes, and then do the rest piecemeal?

The series (currently based on v5.5.10) consists of:

01..07: These are various bugs I came across while looking for code to
    replace.  They are independent of the rest of the series, but related.
08: (EXT4) This is a bit of code I'm not sure about.  Sometimes a
    random number is used, and sometimes a hash is used as input to the
    range reduction.  Does the modulo have to be preserved for backward
    compatibility?
09: If the range is a compile-time constant power of 2, then gcc optimizes
    the modulo better than the multiply in prandom_u32_max().  This patch
    fixes that, so that you don't have to worry about the numerical
    value of the range; prandom_u32_max() is always as good or better.
10: This is a very optional patch, for disucssion.  When the range is
    a compile-time constant, making the output of prandom_u32_max()
    perfectly uniform is quite cheap.  This adds the extra test
    and retry loop to that common special case.  Worth bothering?
11: This is the big one (which probably needs to be broken up by
    subsystem), doing a treewide replacement of prandom_u32() % range,
    when the range is not obviously a power of 2.
12: The same, for prandom_u32_state()
13..19: These are patches that were pulled out of the previous two
    because they're involve some more complex code changes.
20..23: Changes to the prandom_u32() generator itself.  Including
    switching to a stronger & faster PRNG.
24..35: Places where crypto-strength get_random_* was used, but only
    pseudorandom numbers are justified.  Examples are:
    - self-test code
    - Seeding other PRNGs
    - random backoffs and timeouts
36..38: Improvements to the batched entropy pool in random.c.
39: (ARM64) Avoid the need for a temporary buffer (and subsequent wiping)
    when transferring random seed material across kexec.
40..44: Replace get_random_bytes() with get_random_{u32,u64,long},
    where the slightly weaker security guarantees of the latter
    suffice.
45: Add a get_random_max() function, using batched crypto-quality
    entropy.  This is more complex than prandom_u32_max()
    because it has to support 64-bit results and is perfectly
    uniform in all cases.
46..49: Use get_random_max in various applications
50: Is the first part of the next phase.  This adds a function to
    fill a byte buffer from the batched entropy buffer, a drop-in
    replacement for get_random_bytes().  I'm particularly seeking
    comment on what this function, with its different security
    guarantees, should be called.  One option I'm considering is
    to name it get_random_bytes, and move the (relatively few)
    call sites that really need unbacktrackable random numbers
    to another name like get_secret_bytes().

George Spelvin (50):
  IB/qib: Delete struct qib_ivdev.qp_rnd
  lib/fault-inject.c: Fix off-by-one error in probability
  fault-inject: Shrink struct fault_attr
  batman-adv: fix batadv_nc_random_weight_tq
  net/rds/bind.c: Use prandom_u32_max()
  ubi/debug: Optimize computation of odds
  mm/slab: Use simpler Fisher-Yates shuffle
  fs/ext4/ialloc.c: Replace % with reciprocal_scale() TO BE VERIFIED
  <linux/random.h> prandom_u32_max() for power-of-2 ranges
  <linux/random.h> Make prandom_u32_max() exact for constant ranges
  Treewide: Extirpate "prandom_u32() % range"
  Treewide: Extirpate prandom_u32_state(rnd) % range
  Avoid some useless msecs/jiffies conversions
  crypto/testmgr.c: use prandom_u32_max() & prandom_bytes()
  drivers/block/drbd/drbd_main: fix _drbd_fault_random()
  include/net/red.h: Simplify red_random() TO BE VERIFIED
  net/802/{garp,mrp}.c: Use prandom_u32_max instead of manual equivalent
  net/ipv6/addrconf.c: Use prandom_u32_max for rfc3315 backoff time computation
  net/sched/sch_netem: Simplify get_crandom
  lib/random32: Move prandom_warmup() inside prandom_seed_early()
  lib/random32.c: Change to SFC32 PRNG
  lib/random32: Use random_ready_callback for seeding.
  prandom_seed_state(): Change to 32-bit seed type.
  crypto4xx_core: Use more appropriate seed for PRNG
  HID: hid-lg: We only need pseudorandom bytes for the address
  drivers/nfc/nfcsim: use prandom_32() for time delay
  drivers/s390/scsi/zcsp_fc.c: Use prandom_u32_max() for backoff
  drivers/target/iscsi: Replace O(n^2) randomization
  fs/ocfs2/journal: Use prandom_u32() and not /dev/random for timeout
  kernel/locking/test-ww_mutex.c: Use cheaper prandom_u32_max()
  lib/nodemask.c: Use cheaper prandom_u32_max() in node_random()
  lib/test*.c: Use prandom_u32_max()
  lib/test_vmalloc.c: Use pseudorandom numbers
  mm/slub.c: Use cheaper prandom source in shuffle_freelist
  USB: serial: iuu_phoenix: Use pseudorandom for xmas mode
  random: Merge batched entropy buffers
  random: Simplify locking of batched entropy
  random: use chacha_permute() directly
  arm: kexec_file: Avoid temp buffer for RNG seed
  arch/*/include/asm/stackprotector.h: Use get_random_canary() consistently
  drivers/block/drbd/drbd_nl.c: Use get_random_u64()
  drivers/ininiband: Use get_random_u32()
  drivers/isdn: Use get_random_u32()
  arm64: ptr auth: Use get_random_u64 instead of _bytes
  random: add get_random_max() function
  mm/shuffle.c: use get_random_max()
  kernel/bpf/core.c: Use get_random_max32()
  arch/arm/kernel/process.c: Use get_random_max32() for sigpage_addr()
  arch/x86/entry/vdso/vma.c: Use get_random_max32() for vdso_addr
  random: add get_random_nonce()

 arch/arm/include/asm/stackprotector.h         |   9 +-
 arch/arm/kernel/process.c                     |   2 +-
 arch/arm64/include/asm/pointer_auth.h         |  20 +-
 arch/arm64/include/asm/stackprotector.h       |   8 +-
 arch/arm64/kernel/machine_kexec_file.c        |   8 +-
 arch/arm64/kernel/pointer_auth.c              |  62 +-
 arch/mips/include/asm/stackprotector.h        |   7 +-
 arch/powerpc/include/asm/stackprotector.h     |   6 +-
 arch/sh/include/asm/stackprotector.h          |   8 +-
 arch/x86/entry/vdso/vma.c                     |   2 +-
 arch/x86/include/asm/stackprotector.h         |   4 +-
 arch/x86/mm/pageattr-test.c                   |   4 +-
 arch/xtensa/include/asm/stackprotector.h      |   7 +-
 crypto/testmgr.c                              |  21 +-
 drivers/block/drbd/drbd_main.c                |  37 +-
 drivers/block/drbd/drbd_nl.c                  |   4 +-
 drivers/char/random.c                         | 581 +++++++++++++-----
 drivers/crypto/amcc/crypto4xx_core.c          |   7 +-
 drivers/crypto/chelsio/chtls/chtls_io.c       |   4 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c  |   4 +-
 drivers/hid/hid-lg.c                          |   2 +-
 drivers/infiniband/core/cm.c                  |   2 +-
 drivers/infiniband/core/cma.c                 |   5 +-
 drivers/infiniband/core/sa_query.c            |   2 +-
 drivers/infiniband/hw/cxgb4/id_table.c        |   4 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |   2 +-
 drivers/infiniband/hw/qib/qib_verbs.c         |   2 -
 drivers/infiniband/hw/qib/qib_verbs.h         |   1 -
 drivers/infiniband/sw/siw/siw_mem.c           |   9 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c           |   3 +-
 drivers/isdn/mISDN/tei.c                      |   5 +-
 drivers/mmc/core/core.c                       |   4 +-
 drivers/mtd/nand/raw/nandsim.c                |   4 +-
 drivers/mtd/tests/mtd_nandecctest.c           |  10 +-
 drivers/mtd/tests/stresstest.c                |  15 +-
 drivers/mtd/ubi/debug.c                       |   2 +-
 drivers/mtd/ubi/debug.h                       |   6 +-
 drivers/net/ethernet/broadcom/cnic.c          |   3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 drivers/nfc/nfcsim.c                          |   3 +-
 drivers/s390/scsi/zfcp_fc.c                   |   2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                 |  10 +-
 drivers/scsi/qedi/qedi_main.c                 |   2 +-
 .../target/iscsi/iscsi_target_seq_pdu_list.c  |  72 +--
 drivers/usb/serial/iuu_phoenix.c              |   7 +-
 fs/ceph/inode.c                               |   2 +-
 fs/ceph/mdsmap.c                              |   2 +-
 fs/ext2/ialloc.c                              |   3 +-
 fs/ext4/ialloc.c                              |   5 +-
 fs/ext4/super.c                               |   8 +-
 fs/ocfs2/journal.c                            |   7 +-
 fs/ubifs/debug.c                              |  11 +-
 fs/ubifs/lpt_commit.c                         |  12 +-
 fs/xfs/xfs_error.c                            |   2 +-
 include/crypto/chacha.h                       |   1 +
 include/linux/fault-inject.h                  |   4 +-
 include/linux/random.h                        | 279 ++++++++-
 include/net/red.h                             |  22 +-
 kernel/bpf/core.c                             |   4 +-
 kernel/locking/test-ww_mutex.c                |  23 +-
 lib/crypto/chacha.c                           |   2 +-
 lib/fault-inject.c                            |  12 +-
 lib/find_bit_benchmark.c                      |   4 +-
 lib/interval_tree_test.c                      |   9 +-
 lib/nodemask.c                                |   2 +-
 lib/random32.c                                | 558 +++++++++--------
 lib/rbtree_test.c                             |   2 +-
 lib/reed_solomon/test_rslib.c                 |   4 +-
 lib/sbitmap.c                                 |   7 +-
 lib/test-string_helpers.c                     |   2 +-
 lib/test_bpf.c                                |   2 +-
 lib/test_hexdump.c                            |  10 +-
 lib/test_list_sort.c                          |   2 +-
 lib/test_parman.c                             |   2 +-
 lib/test_vmalloc.c                            |  58 +-
 mm/shuffle.c                                  |   2 +-
 mm/slab.c                                     |  25 +-
 mm/slab_common.c                              |  15 +-
 mm/slub.c                                     |   2 +-
 mm/swapfile.c                                 |   2 +-
 net/802/garp.c                                |   2 +-
 net/802/mrp.c                                 |   2 +-
 net/batman-adv/bat_iv_ogm.c                   |   4 +-
 net/batman-adv/bat_v_elp.c                    |   2 +-
 net/batman-adv/bat_v_ogm.c                    |  10 +-
 net/batman-adv/network-coding.c               |   9 +-
 net/bluetooth/hci_request.c                   |   2 +-
 net/ceph/mon_client.c                         |   2 +-
 net/core/neighbour.c                          |   6 +-
 net/core/pktgen.c                             |  20 +-
 net/core/stream.c                             |   2 +-
 net/ipv4/igmp.c                               |   6 +-
 net/ipv4/inet_connection_sock.c               |   2 +-
 net/ipv6/addrconf.c                           |  17 +-
 net/ipv6/mcast.c                              |  10 +-
 net/packet/af_packet.c                        |   2 +-
 net/rds/bind.c                                |   2 +-
 net/sched/act_gact.c                          |   2 +-
 net/sched/act_sample.c                        |   2 +-
 net/sched/sch_netem.c                         |  23 +-
 net/sctp/socket.c                             |   2 +-
 net/sunrpc/xprtsock.c                         |   2 +-
 net/tipc/socket.c                             |   5 +-
 net/wireless/scan.c                           |   2 +-
 net/xfrm/xfrm_state.c                         |   2 +-
 sound/core/pcm_lib.c                          |   2 +-
 sound/core/pcm_native.c                       |   2 +-
 110 files changed, 1324 insertions(+), 917 deletions(-)

-- 
2.26.0
