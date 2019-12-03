Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8410F62F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 05:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLCEPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 23:15:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbfLCEPZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 23:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575346524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD9dxfbrdVwDZagrDgo/lAvzebPEnmFiLO749DDmUoo=;
        b=fGgx6TAFPjYBMkrLTFZLciLkkOAeM2BzESt6RfLeY5mgb9/BXRQ69M1FK3uQy7CuIDZTMD
        mokfBRawgDFh6AHRuHemlXUCV+mIjz3vlWY6Hc/n+Ujg+YoAxA672lgKc7+biQZUqb6kqU
        bPO7o6SKwBja7QPncc3C5FUkwV0FfuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-5K8dFkmGMuK1cVnLcsZZ2g-1; Mon, 02 Dec 2019 23:15:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A1A1005513;
        Tue,  3 Dec 2019 04:15:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A58D4608E2;
        Tue,  3 Dec 2019 04:15:09 +0000 (UTC)
Date:   Tue, 3 Dec 2019 12:15:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191203041504.GC6245@ming.t460p>
References: <20191128015748.GA3277@ming.t460p>
 <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p>
 <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p>
 <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5K8dFkmGMuK1cVnLcsZZ2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 02, 2019 at 10:26:28PM -0500, Stephen Rust wrote:
> > oops, it should have been (arg4 & 511) !=3D 0.
>=20
> Yep, there they are:
>=20
> # /usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 & 511) !=3D 0) "%d
> %d", arg3, arg4'
> PID     TID     COMM            FUNC             -
> 7411    7411    kworker/31:1H   bio_add_page     512 76
>         bio_add_page+0x1 [kernel]
>         sbc_execute_rw+0x28 [kernel]
>         __target_execute_cmd+0x2e [kernel]
>         target_execute_cmd+0x1c1 [kernel]
>         iscsit_execute_cmd+0x1e7 [kernel]
>         iscsit_sequence_cmd+0xdc [kernel]
>         isert_recv_done+0x780 [kernel]
>         __ib_process_cq+0x78 [kernel]
>         ib_cq_poll_work+0x29 [kernel]
>         process_one_work+0x179 [kernel]
>         worker_thread+0x4f [kernel]
>         kthread+0x105 [kernel]
>         ret_from_fork+0x1f [kernel]
>=20
> 7753    7753    kworker/26:1H   bio_add_page     4096 76

The issue should be in brd_make_request() which assumes that
bvec.bv_len is 512bytes align.

I will figure out one patch for you tomorrow.

Thanks,
Ming

