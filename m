Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754894D68F6
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 20:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiCKTJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 14:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiCKTJp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 14:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9C361BA173
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlvNr3FLw3UO1AdQQ2G8yYlDTU8Pg9z9WXhSRb9XSRw=;
        b=R+ewzgrWHQo8JHCjDL1Q9Lasb0MjayhoC/4My/Qv0xXajPgPar0ARMxIZiY/USycfJY5t6
        E/MAepqG564U601GGPDlcXDo7yGa1WoSGPGCYAnHLxBMblQKMyL6Ryfd9mjwLzkA7ewvKh
        Mx/oZvJnKLCpagCJIhfbVS1xzVf34u0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-2BYmbb47PZ-vEHmw2QJcIA-1; Fri, 11 Mar 2022 14:08:39 -0500
X-MC-Unique: 2BYmbb47PZ-vEHmw2QJcIA-1
Received: by mail-oo1-f69.google.com with SMTP id r10-20020a4a700a000000b0031bf70c4866so7321634ooc.12
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 11:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlvNr3FLw3UO1AdQQ2G8yYlDTU8Pg9z9WXhSRb9XSRw=;
        b=eHCKxR7qK/tKR/GFbA09NIkrA58k/nj7+RhNCPpXfxylX0dG+yghikxuEL27GHRaBm
         3i4LAhduOydsfS22/1ViVzGawFEDfeAly09gfkDjOJoFD2XaEbkywcj5yKY2xXxmooD0
         lZ2jTKUNGaOM0cBUCfv7vDxUZOGyNZvlhscMZEncGZK905b7vkNZh4rzE+nFqAWui2n+
         GwItiby3Fa1dB/xVyn5vOyHh93kA6o5zjE7IzXDBNRUp4J+5fJRqWU8QW7elVYvMKq43
         njz/6LC4PV8cRR07s65DcEZhebcq430rma/DSYeBl2Q+yH3lgXyLxK7h9L85Jf7HxBkK
         mxnw==
X-Gm-Message-State: AOAM532xwFkLNfB+4l5miqN4tSvAOYNCzs1EgEN+a19mM4cblBdznUgJ
        BOhogGmodRm2PRrwEmOQtt5dX0SZrCefvlxX9GZ3HaBdViB/20UZHl/CoKviRYhiqS5BDeV4XUx
        K4B7mSQsCUPUQWLMKCuDRIw==
X-Received: by 2002:a05:6808:e84:b0:2da:391f:9c68 with SMTP id k4-20020a0568080e8400b002da391f9c68mr7435323oil.95.1647025719002;
        Fri, 11 Mar 2022 11:08:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUPNvtJhHdii8ceYYWndqIHtA3+MvF6irPYL+0/UvWhUyWJlWU5Zv0PqAi9U30WMNF+6j4LA==
X-Received: by 2002:a05:6808:e84:b0:2da:391f:9c68 with SMTP id k4-20020a0568080e8400b002da391f9c68mr7435308oil.95.1647025718729;
        Fri, 11 Mar 2022 11:08:38 -0800 (PST)
Received: from loberhel ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
        by smtp.gmail.com with ESMTPSA id bg14-20020a056820080e00b0031d1cf9aef6sm569765oob.48.2022.03.11.11.08.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:08:38 -0800 (PST)
Message-ID: <9aacaa44057b5716b1b78ecbcf71f4b50cd1fde9.camel@redhat.com>
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
From:   Laurence Oberman <loberman@redhat.com>
To:     David Jeffery <djeffery@redhat.com>, linux-rdma@vger.kernel.org
Cc:     target-devel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Date:   Fri, 11 Mar 2022 14:08:36 -0500
In-Reply-To: <20220311175713.2344960-1-djeffery@redhat.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2022-03-11 at 12:57 -0500, David Jeffery wrote:
> With fast infiniband networks and rdma through isert, the isert
> version of
> an iSCSI target can get itself into a deadlock condition from when
> max_cmd_sn updates are pushed to the client versus when commands are
> fully
> released after rdma completes.
> 
> iscsit preallocates a limited number of iscsi_cmd structs used for
> any
> commands from the initiator. While the iscsi window would normally be
> expected to limit the number used by normal SCSI commands, isert can
> exceed
> this limit with commands waiting finally completion. max_cmd_sn gets
> incremented and pushed to the client on sending the target's final
> response, but the iscsi_cmd won't be freed for reuse until after all
> rdma
> is acknowledged as complete.
> 
> This allows more new commands to come in even as older commands are
> not yet
> released. With enough commands on the initiator wanting to be sent,
> this can
> result in all iscsi_cmd structs being allocated and used for SCSI
> commands.
> 
> And once all are allocated, isert can deadlock when another new
> command is
> received. Its receive processing waits for an iscsi_cmd to become
> available.
> But this also stalls processing of the completions which would result
> in
> releasing an iscsi_cmd, resulting in a deadlock.
> 
> This small patch series prevents this issue by altering when and how
> max_cmd_sn changes are reported to the initiator for isert. It gets
> delayed
> until iscsi_cmd release instead of when sending a final response.
> 
> To prevent failure or large delays for informing the initiator of
> changes to
> max_cmd_sn, NOPIN is used as a method to inform the initiator should
> the
> difference between internal max_cmd_sn and what has been passed to
> the
> initiator grow too large.
> 
> David Jeffery (2):
>   isert: support for unsolicited NOPIN with no response.
>   iscsit: increment max_cmd_sn for isert on command release
> 
>  drivers/infiniband/ulp/isert/ib_isert.c    | 11 ++++++-
>  drivers/target/iscsi/iscsi_target.c        | 18 +++++------
>  drivers/target/iscsi/iscsi_target_device.c | 35
> +++++++++++++++++++++-
>  drivers/target/iscsi/iscsi_target_login.c  |  1 +
>  drivers/target/iscsi/iscsi_target_util.c   |  5 +++-
>  drivers/target/iscsi/iscsi_target_util.h   |  1 +
>  include/target/iscsi/iscsi_target_core.h   |  8 +++++
>  include/target/iscsi/iscsi_transport.h     |  1 +
>  8 files changed, 68 insertions(+), 12 deletions(-)
> 

This patch has had exhaustive testing in our lab and finally at a
customer. with 40GB FDR we could not reproduce this issue, when we
moved to 100G EDR it showed up. Its been literally over tested for many
days on two separate installations.

The patch corrected all the stalls and problems seen. Thanks David for
sending this.

Regards
Laurence Oberman

