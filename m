Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9105D6E1273
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDMQhx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDMQhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 12:37:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25243AD
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 09:37:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l11so17068662qtj.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681403871; x=1683995871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHNGtya6pE/tHQYgVtnsnCl229EcO09HpgYX/FNlZSw=;
        b=RV5RUKReZAk2yJYF3F9yTUzsM2N91mD1lhzo8UbjN1YlpRFVKIdDstfGb1zVDan9LY
         cbfVtKAvwDRjqR7uajEVhnSksS2hSAUDW1njHW3bqyQTVJGp1uk2nJHfku7wTfAuy8qF
         mACbdiruux4crM8vBuWQy+sljsnWf+q6i0W3FWarpebwLeYnvuQ6OGEpBxEwSTaeWi8u
         yLkSDJAillqPuu/wdHoULrfRymqAVvQaqHMpR+xCVY1kCkuJPy5lJ4iT7sM0b0I/sMLI
         PqLVn2O7ZKPD7bAespI7lNURZY/5Iox7TXqfZMUIdOe0RMuQ2HmrpMcU1SQIEEU4Nf1L
         jo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681403871; x=1683995871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHNGtya6pE/tHQYgVtnsnCl229EcO09HpgYX/FNlZSw=;
        b=lEkjaxZFgclCpDUcKPMcnYXZnMX4RbOgV64sZqLrZtDSiFY+JyA+laV3PId88d+42a
         GV4czsqpal/bE9Mqgtq4DKnRrMBCY41yd1cc63HJP7MqwJLHe/RKzW5qS+gLDnu9tlha
         h9yB1FXEbfXGN5V0jLGhzpplIbGldJcxzADINVwIu11g3WseVmhXMjF2yGdt/U40Ny99
         /NZvspoft2Gvy1z5pd210g0NbBNLWMkManfLmgekODLLRIuFfg/ksfICoDYVqaXi9mMk
         1lEV42eO8kPtbmen2CjCWGZQSupnnb5Q4NPJ6ugvTd+HF7nXmy/UFgaXUU+tt18Ts7rd
         iX+w==
X-Gm-Message-State: AAQBX9fs9DEpxre5yU3gGrkP++124AOu5DK/6uUmKeCdhit1NmfPY4sr
        sSRdhvv+IWFAGFwLLjBZfljpb3s/nQCHQZTXUlU=
X-Google-Smtp-Source: AKy350byW5AuiwBV64lVYB5s9dIKRZ4+AOtzAzLXfJDU4y1pd/acu29ENFlfZ7Qm3E7vl0sLOy8rfPgIuD/Jr39cwgM=
X-Received: by 2002:a05:622a:1ba2:b0:3bf:c1f3:84bc with SMTP id
 bp34-20020a05622a1ba200b003bfc1f384bcmr792910qtb.11.1681403871271; Thu, 13
 Apr 2023 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com> <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev> <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Thu, 13 Apr 2023 10:37:40 -0600
Message-ID: <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Parav Pandit <parav@nvidia.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Initiator is not net ns aware.

Am I correct in my assessment that this could be a container jailbreak
risk?  We aren't using containers, but we were shocked that RoCEv2
connections magically worked through the physical function which was
not in the netns context.


Thanks,
Mark

On Thu, Apr 13, 2023 at 10:23=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Thursday, April 13, 2023 12:20 PM
> >
> > > From: Mark Lehrer <lehrer@gmail.com>
> > > Sent: Thursday, April 13, 2023 11:39 AM
> > >
> > > > Didn=E2=80=99t get a chance to review the thread discussion.
> > > > The way to use VF is:
> > >
> > > Virtual functions were just a debugging aid.  We really just want to
> > > use a single physical function and put it into the netns.  However, w=
e
> > > will do additional VF tests as it still may be a viable workaround.
> > >
> > > When using the physical function, we are still having no joy using
> > > exclusive mode with mlx5:
> > >
> >
> > static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port) {
> >         struct sockaddr *addr =3D (struct sockaddr *)&port->addr;
> >         struct rdma_cm_id *cm_id;
> >         int ret;
> >
> >         cm_id =3D rdma_create_id(&init_net, nvmet_rdma_cm_handler, port=
,
> >                                                      ^^^^^^^ Nvme targe=
t is not net ns aware.
> >
> >                         RDMA_PS_TCP, IB_QPT_RC);
> >         if (IS_ERR(cm_id)) {
> >                 pr_err("CM ID creation failed\n");
> >                 return PTR_ERR(cm_id);
> >         }
> >
> > >
> Clicked send email too early.
>
> 574 static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>  575                 int idx, size_t queue_size)
>  576 {
> [..]
> 597         queue->cm_id =3D rdma_create_id(&init_net, nvme_rdma_cm_handl=
er, queue,
>  598                         RDMA_PS_TCP, IB_QPT_RC);
>  599         if (IS_ERR(queue->cm_id)) {
>
> Initiator is not net ns aware.
> Given some of the work involves workqueue operation, it needs to hold the=
 reference to net ns and implement the net ns delete routine to terminate.
