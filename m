Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE051AF84
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378282AbiEDUoV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378505AbiEDUoT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 16:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCB24956;
        Wed,  4 May 2022 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oG76id3gGNASA7SryjU8bgEXBKkNZsTlBChl4rvfun0=; b=OTK+mI6NK92TqcK5ViazFqQ68I
        zrVS6De1nsZ3yp+AmfoSudy2E71Kx0wcPfjGk6vj0z9O52RurOiTfUYAhcU0Lj3MGBEcxTh2XgJ7P
        am6/8lVk1LsCbfebWsREaN3kXwJMw3+cGIR1O1C7WyEGE1Jh5rF4vFhzOncEC/62mEBZjQUoci2uB
        7llhtOQZQVCSp0eR2hyRa9MhFvX9CjchDti1qiKjUJMVJj+8WishZSPCv9lHuEpEFCYu/ydCRM9C7
        A/SliFhc9sjwSqGHR5EXpt5i0R92/fBfcNU8ec1f4eSKNxoB3l8LAe4va5jhT78/eO7JIM2JU9ouR
        Q3LQPtpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmLna-00Cd4C-94; Wed, 04 May 2022 20:40:38 +0000
Date:   Wed, 4 May 2022 13:40:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: siw_cm.c:255 siw_cep_put+0x125/0x130 kernel warning while
 testing blktests srp/002 v5.17-rc7
Message-ID: <YnLkxglbU157KkNK@bombadil.infradead.org>
References: <BYAPR15MB2631988B13EE2E336FD2ED4E99F29@BYAPR15MB2631.namprd15.prod.outlook.com>
 <1ec3f1d2-887d-f66c-6221-6319afc4a3e9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec3f1d2-887d-f66c-6221-6319afc4a3e9@linux.alibaba.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 21, 2022 at 10:02:47AM +0800, Cheng Xu wrote:
> 
> 
> On 4/19/22 11:53 PM, Bernard Metzler wrote:
> > > -----Original Message-----
> > > From: Cheng Xu <chengyou@linux.alibaba.com>
> > > Sent: Monday, 18 April 2022 10:29
> > > To: Luis Chamberlain <mcgrof@kernel.org>; Bernard Metzler
> > > <BMT@zurich.ibm.com>; Bart Van Assche <bvanassche@acm.org>
> > > Cc: linux-block@vger.kernel.org; linux-rdma@vger.kernel.org; Pankaj Raghav
> > > <pankydev8@gmail.com>; Pankaj Raghav <p.raghav@samsung.com>
> > > Subject: [EXTERNAL] Re: siw_cm.c:255 siw_cep_put+0x125/0x130 kernel
> > > warning while testing blktests srp/002 v5.17-rc7
> > > 
> > > 
> > > 
> > > On 4/15/22 7:31 AM, Luis Chamberlain wrote:
> > > 
> > > <...>
> > > 
> > > > [  195.218783] ------------[ cut here ]------------
> > > > [  195.221242] WARNING: CPU: 7 PID: 201 at
> > > drivers/infiniband/sw/siw/siw_cm.c:255 siw_cep_put+0x125/0x130 [siw]
> > > > [  195.222838] Modules linked in: ib_srp(E) scsi_transport_srp(E)
> > > target_core_pscsi(E) target_core_file(E) ib_srpt(E) target_core_iblock(E)
> > > target_core_mod(E) rdma_cm(E) iw_cm(E) ib_cm(E) scsi_debug(E) siw(E)
> > > null_blk(E) ib_umad(E) ib_uverbs(E) sd_mod(E) sg(E) dm_service_time(E)
> > > scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) dm_multipath(E) ib_core(E)
> > > dm_mod(E) nvme_fabrics(E) kvm_intel(E) kvm(E) irqbypass(E)
> > > crct10dif_pclmul(E) ghash_clmulni_intel(E) aesni_intel(E) crypto_simd(E)
> > > cryptd(E) joydev(E) evdev(E) serio_raw(E) cirrus(E) drm_shmem_helper(E)
> > > drm_kms_helper(E) virtio_balloon(E) cec(E) i6300esb(E) button(E) drm(E)
> > > configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E)
> > > jbd2(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E)
> > > libcrc32c(E) crc32c_generic(E) virtio_net(E) net_failover(E) failover(E)
> > > virtio_blk(E) ata_generic(E) uhci_hcd(E) ehci_hcd(E) crc32_pclmul(E)
> > > crc32c_intel(E) ata_piix(E) psmouse(E) nvme(E) libata(E) virtio_pci(E)
> > > > [  195.222986]  virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E)
> > > usbcore(E) virtio(E) usb_common(E) scsi_mod(E) nvme_core(E) i2c_piix4(E)
> > > virtio_ring(E) t10_pi(E) scsi_common(E) [last unloaded: null_blk]
> > > > [  195.241036] sd 3:0:0:1: [sdd] Attached SCSI disn
> > > > [  195.241188] CPU: 2 PID: 201 Comm: kworker/u16:22 Kdump: loaded
> > > Tainted: G            E     5.17.0-rc7 #1
> > > > [  195.246053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 1.15.0-1 04/01/2014
> > > > [  195.249123] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> > > > [  195.251274] RIP: 0010:siw_cep_put+0x125/0x130 [siw]
> > > > [  195.253548] Code: bb c0 e8 ae 74 0f d7 48 89 ef 5d 41 5c 41 5d e9 b1 d6 ef
> > > d6 5d be 03 00 00 00 41 5c 41 5d e9 22 b7 0c d7 0f 0b e9 f3 fe ff ff <0f> 0b e9 1c
> > > ff ff ff 0f 1f 40 00 0f 1f 44 00 00 55 48 8d 6f 20 53
> > > > [  195.258982] RSP: 0018:ffffbc53404ebc98 EFLAGS: 00010286
> > > > [  195.261018] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
> > > 0000000000000000
> > > > [  195.263569] RDX: 0000000000000001 RSI: 0000000000000246 RDI:
> > > ffffa03d1102a924
> > > > [  195.266151] RBP: ffffa03d1102a900 R08: ffffa03d1102a920 R09:
> > > ffffbc53404ebc50
> > > > [  195.269150] R10: ffffffff98a060e0 R11: 0000000000000000 R12:
> > > ffffa03cc4297000
> > > > [  195.272744] R13: ffffa03d2a48aea0 R14: ffffa03d2a48ae78 R15:
> > > ffffa03cc427ad58
> > > > [  195.275575] FS:  0000000000000000(0000) GS:ffffa03df7c80000(0000)
> > > knlGS:0000000000000000
> > > > [  195.278932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  195.280963] CR2: 00005590bc2e4fe8 CR3: 000000008500a004 CR4:
> > > 0000000000770ee0
> > > > [  195.282803] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > 0000000000000000
> > > > [  195.284650] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > 0000000000000400
> > > > [  195.286522] PKRU: 55555554
> > > > [  195.287998] Call Trace:
> > > > [  195.289210]  <TASK>
> > > > [  195.290969]  siw_reject+0xac/0x180 [siw]
> > > > [  195.292679]  iw_cm_reject+0x68/0xc0 [iw_cm]
> > > > [  195.294136]  cm_work_handler+0x59d/0xe20 [iw_cm]
> > > > [  195.295588]  process_one_work+0x1e2/0x3b0
> > > > [  195.298338]  worker_thread+0x50/0x3a0
> > > > [  195.300330]  ? rescuer_thread+0x390/0x390
> > > > [  195.302269]  kthread+0xe5/0x110
> > > > [  195.304062]  ? kthread_complete_and_exit+0x20/0x20
> > > > [  195.307612]  ret_from_fork+0x1f/0x30
> > > > [  195.309585]  </TASK>
> > > > [  195.310674] ---[ end trace 0000000000000000 ]---
> > > > [  195.313290] scsi host4: ib_srp: REJ received
> > > > [  195.313293] scsi host4:   REJ reason 0xffffff98
> > > > [  195.315433] scsi host4: ib_srp: Connection 0/8 to 172.17.8.113 failed
> > > > [  195.472718] ib_srp:srp_parse_in: ib_srp: 172.17.8.113 -> 172.17.8.113:0
> > > > [  195.472739] ib_srp:srp_parse_in: ib_srp: 172.17.8.113:5555 ->
> > > 172.17.8.113:5555
> > > > [  195.472807] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe5b:90dc%3] ->
> > > [fe80::5054:ff:fe5b:90dc]:0/202442865%3
> > > > > [0] INVALID URI REMOVED
> > > 3A__github.com_mcgrof_kdevops&d=DwIGaQ&c=jf_iaSHvJObTbx-
> > > siA1ZOg&r=2TaYXQ0T-
> > > r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&m=7dWDVPFaNFXoRqokXmPFFy
> > > XkVL2yItLNzYUDfM4ULTg&s=1ezv_qa-
> > > ujLTftm7OxJ5xNZuoKrc70DJPBDccqZokbY&e=
> > > >   >    Luis
> > > 
> > > Hi, Bernard
> > > 
> > > I reproduced this issue, and it looks like a condition race between
> > > 'cm_work_handler' and 'siw_cm_work_handler'.
> > > 
> > > ----------------------------------------------------------------
> > >    Thread0:                         Thread1:
> > >    siw_cm_work_handler              cm_work_handler
> > > ----------------------------------------------------------------
> > > step0:
> > > siw_cm_upcall with
> > > IW_CM_EVENT_CONNECT_REQUEST
> > > 
> > >                               ===> cm_conn_req_handler
> > >                                      ...
> > >                                        cm_id->cm_handler (failed)
> > >                                        iw_cm_reject
> > >                                             siw_reject
> > > 
> > > *step1*:
> > > detach cep with listen_cep
> > > ----------------------------------------------------------------
> > > 
> > > When siw_reject is called in cm_work_handler, the related cep may have
> > > not been detached with its listen_cep, through the two steps are very
> > > close.
> > > 
> > > I think one simple way to fix this issue is keep step1 under
> > > siw_cep_set_inuse's protection, and this will make siw_reject will be
> > > pending util siw_cm_work_handler release the lock:
> > > 
> > > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> > > b/drivers/infiniband/sw/siw/siw_cm.c
> > > index 7acdd3c3a599..f033b6da1e9f 100644
> > > --- a/drivers/infiniband/sw/siw/siw_cm.c
> > > +++ b/drivers/infiniband/sw/siw/siw_cm.c
> > > @@ -968,13 +968,15 @@ static void siw_accept_newconn(struct siw_cep
> > > *cep)
> > > 
> > >                   siw_cep_set_inuse(new_cep);
> > >                   rv = siw_proc_mpareq(new_cep);
> > > -               siw_cep_set_free(new_cep);
> > > 
> > >                   if (rv != -EAGAIN) {
> > >                           siw_cep_put(cep);
> > >                           new_cep->listen_cep = NULL;
> > > +                       siw_cep_set_free(new_cep);
> > >                           if (rv)
> > >                                   goto error;
> > > +               } else {
> > > +                       siw_cep_set_free(new_cep);
> > >                   }
> > >           }
> > >           return;
> > > 
> > > Thanks,
> > > Cheng Xu
> > 
> > Hi Cheng, many thanks for looking into it! Unfortunately
> > I am out next 12 days until May. I will immediately look into
> > it when back. Your explanation sounds reasonable, but I'd
> > like to fully understand.
> I'd like to send a patch to fix this. When you back, you can review this
> issue and the patch.
> 
> Was it fixing the issue for you?
> 
> Sure, With this change, the WARN in dmesg does not appear any more in
> my tests.
> 
> Thanks,
> Cheng Xu

*poke*

Would be good to get a fix merged. And if a patch is posted does this
need to go to stable?

  Luis
