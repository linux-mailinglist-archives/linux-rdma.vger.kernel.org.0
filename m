Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D887CCB35
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbjJQSvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbjJQSvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 14:51:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C7FC
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 11:51:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so7057647276.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697568701; x=1698173501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMr/1mG+TV2b38SZDmIyaaFpy3iyde/YvVktxNN91tc=;
        b=BPixDxNrs7Wf3/dJ5cA5OqvYduQsqkTi945Zi7Lm/2ND4rIckHlPQmIzALfX/DxeQt
         ECaJ5SoGYkHKQOGa8cboqN9+soxO3P6iuKiWACkj6lkZ6cFkL957sCDtR21WE8Od3Em1
         goTVYHwk7KekSir3WnFb7mkQrVV+fE0+k+O+4FF2yLSCjUhJcCl760PAYdcOumaFDuUH
         kZQJJmEa8r99zgahfjG1Be5HbPWda0K9XjKgycd7tKPDx+gS0wiULhHDiQLPsL4kIvK8
         yoY6MI8DbPTt29TX83J1KsEbfARGd3/9hv5nduh/zDRU0XsxcnR53kgGUWOXT/gH3PuJ
         /omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568701; x=1698173501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMr/1mG+TV2b38SZDmIyaaFpy3iyde/YvVktxNN91tc=;
        b=rkTT/hi0kI41RisBfSEqCUfTQjbZ2oK5N/cXCgHnFIkbWv+NRoMWg85bR9NCXyqWXp
         /rlRNDACxAVGP5clFOR9OYZtdzvhI2jUOcRfpAU0Ldq/toFSQ0e4ByxsKScdcIO49eoQ
         uuwnxQAAV66mIMy+az/6U4P3IBQCBruLrhfGVA6E5rnte6jxdLPhgtGAofhmnHMEPTUg
         M72gTyH1GHXzqU+eiNerl/sgLfjIMbCi5yKbki/SF9AQSXRzobX/G4gFkkQH3ymanccY
         ELK2OcEHd83B/oKsaARO8+y8VC3nQnDiuOfa1X/lCWW0nlHuVh5renExzx6YUKEvMbmC
         p6+Q==
X-Gm-Message-State: AOJu0Yzh4bc2H5JG/ukPSL8TeZokq6LX15Yj7N+o5YqvvTSEwcB3Job3
        H20SlCnRFJ0R5l+IWLrrdRHD1Q==
X-Google-Smtp-Source: AGHT+IF5U7IeKBiOpcTfw9EnOrgcpcHl2/Lqmr8Ovo0XTLUDnB866+Pw/tfvAzz/66GT1dvdREEXLw==
X-Received: by 2002:a25:aaa9:0:b0:d9a:d90d:7b42 with SMTP id t38-20020a25aaa9000000b00d9ad90d7b42mr3253096ybi.1.1697568701602;
        Tue, 17 Oct 2023 11:51:41 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id cf31-20020a056902181f00b00d9ab46073f1sm694915ybb.52.2023.10.17.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:51:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qspAJ-002tyf-9K;
        Tue, 17 Oct 2023 15:51:39 -0300
Date:   Tue, 17 Oct 2023 15:51:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Message-ID: <20231017185139.GA691768@ziepe.ca>
References: <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <20231017175821.GG282036@ziepe.ca>
 <8801fc68-0e8e-4bb1-acaa-597bf72a567d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8801fc68-0e8e-4bb1-acaa-597bf72a567d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 17, 2023 at 01:44:58PM -0500, Bob Pearson wrote:
> On 10/17/23 12:58, Jason Gunthorpe wrote:
> > On Tue, Oct 17, 2023 at 12:09:31PM -0500, Bob Pearson wrote:
> > 
> >  
> >> For qp#167 the call to srp_post_send() is followed by the rxe driver
> >> processing the send operation and generating a work completion which
> >> is posted to the send cq but there is never a following call to
> >> __srp_get_rx_iu() so the cqe is not received by srp and failure.
> > 
> > ? I don't see this funcion in the kernel?  __srp_get_tx_iu ?
> >  
> >> I don't yet understand the logic of the srp driver to fix this but
> >> the problem is not in the rxe driver as far as I can tell.
> > 
> > It looks to me like __srp_get_tx_iu() is following the design pattern
> > where the send queue is only polled when it needs to allocate a new
> > send buffer - ie the send buffers are pre-allocated and cycle through
> > the queue.
> > 
> > So, it is not surprising this isn't being called if it is hung - the
> > hang is probably something that is preventing it from even wanting to
> > send, which is probably a receive side issue.
> > 
> > Followup back up from that point to isolate what is the missing
> > resouce to trigger send may bring some more clarity.
> > 
> > Alternatively if __srp_get_tx_iu() is failing then perhaps you've run
> > into an issue where it hit something rare and recovery does not work.
> > 
> > eg this kind of design pattern carries a subtle assumption that the rx
> > and send CQ are ordered together. Getting a rx CQ before a matching tx
> > CQ can trigger the unusual scenario where the send side runs out of
> > resources.
> > 
> > Jason
> 
> In all the traces I have looked at the hang only occurs once the final
> send side completions are not received. This happens when the srp
> driver doesn't poll (i.e. call ib_process_cq_direct). The rest is
> my conjecture. Since there are several (e.g. qp#167 through qp#211 (odd))
> qp's with missing completions there are 23 iu's tied up when srp hangs.
> Your suggestion makes sense as why the hang occurs. When the test
> finishes the qp's are destroyed and the driver calls ib_process_cq_direct
> again which cleans up the resources.
> 
> The problem is that there isn't any obvious way to find a thread related
> to the missing cqe to poll for them. I think the best way to fix this is
> to convert the send side cq handling to interrupt driven (as is the case
> with the srpt driver.) The provider drivers have to run in any case to
> convert cqe's to wc's so there isn't much penalty to call the cq
> completion handler since there is already software running and then you
> will get reliable delivery of completions.

Can you add tracing to show that SRP is running out of SQ resources,
ie __srp_get_tx_iu() fails and that is a precondition for the hang?

I am fully willing to belive that is not ever tested.

Otherwise if srp thinks it has SQ resources then the SQ is probably
not the cause of the hang.

Jason
