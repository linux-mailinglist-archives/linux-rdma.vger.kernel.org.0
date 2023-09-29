Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F377B37E9
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjI2Q2Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjI2Q2X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 12:28:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619371A4
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 09:28:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50337b43ee6so23200723e87.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696004899; x=1696609699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1jnYTA/sVS+Z8Orhdi2AQdhdCY0rlD66I6Sde9ZBPos=;
        b=A1D/aDkxoD36fZB/azyCnZ469iavmiwwNtK5Tl89BbnZuJ1/ws43XTkdatoIo8Ei8k
         +DkaztthYyBp51myMax9lefOD8qjBHDXZCL6ey8NkVmUCb6/xjSCMHbLPT4ZuZN1hLaD
         XSS0lojFNR0CDNTgowJBgTLkNdn8VUbu5JEfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004899; x=1696609699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jnYTA/sVS+Z8Orhdi2AQdhdCY0rlD66I6Sde9ZBPos=;
        b=WbtRICMc2jKf4vARN8lefka2C1FPldKBNb4fsuAPQFRAxfQF10slf/ab0SO069wL5W
         sKiULnY8VrhAx73/CvkgsmCAW9H7n8nwd/jZKx+E8Xgu/lviNimCpYUaUYxG8aZAYQ9g
         I9Ce6BRA4GW4k5yN8TmtzIOhV1IxyATf1aJDkDRkiCQUj9lg7uZAwqA7SitXO7yt26G1
         mNY+56D6Ww/0JLFrokCtT7Q3ZXCregDE9Oaaq0kfkC1vdIWMkiWN/N5gRQZ/OU+4dWxd
         KUsImdcrsd6wmDskaeunZlEMDZD8aDVzQPuR6tqGjU/AN1/y8mroiQJUI1qyo/yywz7c
         NHwg==
X-Gm-Message-State: AOJu0YxDDDwHfNlamfhsyYtDhWwkAC2xAEzeFk0c/2EXjtppq8cn8QAG
        qIMWaST68bw5CDpjcNa2s4b37AL1WSfOktYkZxtjuAdxgsk=
X-Google-Smtp-Source: AGHT+IGOc6LeYiO7m4ZUaw9t10SwZQp6l3dpZq6L6j61zXcXyBGLoG/u1u9cy4lBecWFUCi/27Kw0A==
X-Received: by 2002:ac2:43b7:0:b0:500:9b7d:ee3c with SMTP id t23-20020ac243b7000000b005009b7dee3cmr3961319lfl.7.1696004899489;
        Fri, 29 Sep 2023 09:28:19 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id bi37-20020a0565120ea500b005044911b32bsm2649898lfb.115.2023.09.29.09.28.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 09:28:19 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c1886777d9so52307071fa.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 09:28:18 -0700 (PDT)
X-Received: by 2002:a17:907:2722:b0:9a1:cdf1:ba3 with SMTP id
 d2-20020a170907272200b009a1cdf10ba3mr4628345ejl.27.1696004552316; Fri, 29 Sep
 2023 09:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs> <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <20230928212656.GC189345@mit.edu> <CAHk-=wjTynK9BdGbi+8eShU77nkPvipFwRxEd1TSBrw2+LiuDg@mail.gmail.com>
 <CAOQ4uxg5ctY9yCjLOjN1nETAcEuNb2UERnYuDv7PoErdxX=WUw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg5ctY9yCjLOjN1nETAcEuNb2UERnYuDv7PoErdxX=WUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Sep 2023 09:22:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTZ=6QkE_eksL+kzywj2cA_kiY-ydZKoz-+kBQwtNWwQ@mail.gmail.com>
Message-ID: <CAHk-=wjTZ=6QkE_eksL+kzywj2cA_kiY-ydZKoz-+kBQwtNWwQ@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mattia Dongili <malattia@linux.it>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anders Larsen <al@alarsen.net>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@telemann.coda.cs.cmu.edu, linux-efi@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 28 Sept 2023 at 20:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> OTOH, it is perfectly fine if the vfs wants to stop providing sub 100ns
> services to filesystems. It's just going to be the fs problem and the
> preserved pre-historic/fine-grained time on existing files would only
> need to be provided in getattr(). It does not need to be in __i_mtime.

Hmm. That sounds technically sane, but for one thing: if the aim is to try to do

 (a) atomic timestamp access

 (b) shrink the inode

then having the filesystem maintain its own timestamp for fine-grained
data will break both of those goals.

Yes, we'd make 'struct inode' smaller if we pack the times into one
64-bit entity, but if btrfs responds by adding mtime fields to "struct
btrfs_inode", we lost the size advantage and only made things worse.

And if ->getattr() then reads those fields without locking (and we
definitely don't want locking in that path), then we lost the
atomicity thing too.

So no. A "but the filesystem can maintain finer granularity" model is
not acceptable, I think.

If we do require nanoseconds for compatibility, what we could possibly
do is say "we guarantee nanosecond values for *legacy* dates", and say
that future dates use 100ns resolution. We'd define "legacy dates" to
be the traditional 32-bit signed time_t.

So with a 64-bit fstime_t, we'd have the "legacy format":

 - top 32 bits are seconds, bottom 32 bits are ns

which gives us that ns format.

Then, because only 30 bits are needed for nanosecond resolution, we
use the top two bits of that ns field as flags. '00' means that legacy
format, and '01' would mean "we're not doing nanosecond resolution,
we're doing 64ns resolution, and the low 6 bits of the ns field are
actually bits 32-37 of the seconds field".

That still gives us some extensibility (unless the multi-grain code
still wants to use the other top bit), and it gives us 40 bits of
seconds, which is quite a lot.

And all the conversion functions will be simple bit field
manipulations, so there are no expensive ops here.

Anyway, I agree with the "let's introduce the accessor functions
first, we can do the 'pack into one word' decisions later".

                Linus
