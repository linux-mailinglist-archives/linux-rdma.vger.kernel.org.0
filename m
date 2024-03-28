Return-Path: <linux-rdma+bounces-1470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697F787D80F
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Mar 2024 03:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C71C21312
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Mar 2024 02:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E6566D;
	Sat, 16 Mar 2024 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OS38TBQX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328033FEC
	for <linux-rdma@vger.kernel.org>; Sat, 16 Mar 2024 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710557577; cv=none; b=kBlXfoU1dvIC8U2oD/BROlvnMI3kb72ajdTMcehhhxCqt3NEauWPhLLpXtHExFdUk16r/MdanlZKTyapYaY/1DTnGBBpMDAwrj9abpX72Fno0PrKxFfYjeiwCa4k/TxlF3M72MeyHecxYO6qNX9C+MP04huFndv5Vc0D6LgrmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710557577; c=relaxed/simple;
	bh=ONoYL4XYOrO/6V38FWRzOpd8quw8P9OYCw818URL5SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXtySA/M/aI5NLcz73REx43XhUXDzc7aD/Ud76/guosUJbu9O/3688VvOCkenwy3AM1MVL1IMRHuWzoodJQmhaINsNuh7RqUh1Yz0KlfbMCeML0EWf2H1BN/XcwVv4ZYWzyUKD5I5lYYhj3JStbfXw2DGlY6ztj+qj+25nYjeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OS38TBQX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29dfad24f36so720657a91.0
        for <linux-rdma@vger.kernel.org>; Fri, 15 Mar 2024 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710557573; x=1711162373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBoX08MQ+GnGsn3Ys1XDLWs0vSpU6QZ104y6JQ1iJRA=;
        b=OS38TBQXdJvmCPcBqtVgseCBD92KPMKjZB5CNB1A04ssBRuxFtzhRPn1GciuiaZp/t
         ZH5bJFCL/HpWMw666xaF9ceynO1+jhCFyauCWBZUGDOD1jkHbl+xoO/jG6Zp360GwjSj
         i66QeBxSRG87tkQkjPc2WA1M6sUtCwvS7DgrAnPORxwYyGeQf+wuJHESEF51ACE4d88K
         v4nAXQtE+CrgRNknVt8a/+cuKu8aypzYeDig59JPHUtRYsAH3lqkfrJopeugL+PkOFJP
         r/+/nAs2w8rmwShkaEIQMuFTq7jUIHueDrkctHW9aB3EK7WEeQJ4EnyrT3UmzNQXv8kk
         1a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710557573; x=1711162373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBoX08MQ+GnGsn3Ys1XDLWs0vSpU6QZ104y6JQ1iJRA=;
        b=iJPdBgO2iVY43J0wd1XDviRDYKE7zMqppeCHjlVgqbuSsV8EkDkk5dsugnLWXVzkgG
         zJbg5AQssG1ninFqwsfFGwKezJRdRWfZ05G3JyGTARYYfCDgykHsiXSkmv5onAKIEJNy
         BD+9hF2Bg+CR4cfxcv22wqcn60EvzTdHDyi0iJyV6BKw/LoWaW+cLqDr9SDB10YXm2ZT
         oLH0x9cjyKX9+4rUWTTccQSwnTQd+zu3k+bTpVNPA++t1eYDFU3WsrsBCS3hjdVESe5R
         VM4OM7bb+SMR+c0JPlQsz96ZkJ9TluDI4gJue2bUNCwXuL4rNDobcohZ2i9ldcpBlChA
         A1+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJdWXxfuGMxh2/AuCPFJv5QD/KW+cNThW/diFeb/23LFQ1zgiHDoUx/xfPLFo6kccfSC62ny3ieNMmtx4OjRpvIukqNluHiC7rNw==
X-Gm-Message-State: AOJu0YzHhNYNU47g4HbQrZIWUX4P4Gd/OEkFP2Vie1SfgWi7WwGDoGYA
	DQ1fiYa7bIDjho1Z0YbqgIlwYHWLMpMwtaZZ+NrTiKdXZIiQvrdFztmxe2eJYKU=
X-Google-Smtp-Source: AGHT+IF+mhHYlAObRzpfXYn3IGnPDczeVjZaH7QVUqvtIq9UdyOULCBCqzY79zAwu/GemLxZ182Fng==
X-Received: by 2002:a17:903:2446:b0:1dd:9cb3:8f96 with SMTP id l6-20020a170903244600b001dd9cb38f96mr6055795pls.42.1710557572964;
        Fri, 15 Mar 2024 19:52:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b001dddbb58d5esm4736209pln.109.2024.03.15.19.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 19:52:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rlKAC-002Wnj-2F;
	Sat, 16 Mar 2024 13:52:48 +1100
Date: Sat, 16 Mar 2024 13:52:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Balbir Singh <bsingharora@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexander Popov <alex.popov@linux.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-fsdevel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kexec@lists.infradead.org,
	bridge@lists.linux.dev, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 11/11] sysctl: treewide: constify the ctl_table argument
 of handlers
Message-ID: <ZfUJgML8tk6RWqOC@dread.disaster.area>
References: <20240315-sysctl-const-handler-v1-0-1322ac7cb03d@weissschuh.net>
 <20240315-sysctl-const-handler-v1-11-1322ac7cb03d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315-sysctl-const-handler-v1-11-1322ac7cb03d@weissschuh.net>

On Fri, Mar 15, 2024 at 09:48:09PM +0100, Thomas Wei�schuh wrote:
> Adapt the proc_hander function signature to make it clear that handlers
> are not supposed to modify their ctl_table argument.
> 
> This is a prerequisite to moving the static ctl_table structs into
> .rodata.
> By migrating all handlers at once a lengthy transition can be avoided.
> 
> The patch was mostly generated by coccinelle with the following script:
> 
>     @@
>     identifier func, ctl, write, buffer, lenp, ppos;
>     @@
> 
>     int func(
>     - struct ctl_table *ctl,
>     + const struct ctl_table *ctl,
>       int write, void *buffer, size_t *lenp, loff_t *ppos)
>     { ... }

Which seems to have screwed up the formatting of the XFS code...

> diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
> index a191f6560f98..a3ca192eca79 100644
> --- a/fs/xfs/xfs_sysctl.c
> +++ b/fs/xfs/xfs_sysctl.c
> @@ -10,12 +10,11 @@ static struct ctl_table_header *xfs_table_header;
>  
>  #ifdef CONFIG_PROC_FS
>  STATIC int
> -xfs_stats_clear_proc_handler(
> -	struct ctl_table	*ctl,
> -	int			write,
> -	void			*buffer,
> -	size_t			*lenp,
> -	loff_t			*ppos)
> +xfs_stats_clear_proc_handler(const struct ctl_table *ctl,
> +			     int			write,
> +			     void			*buffer,
> +			     size_t			*lenp,
> +			     loff_t			*ppos)

... because this doesn't match any format I've ever seen in the
kernel. The diff for this change shold be just:

@@ -10,7 +10,7 @@ static struct ctl_table_header *xfs_table_header;
 #ifdef CONFIG_PROC_FS
 STATIC int
 xfs_stats_clear_proc_handler(
-	struct ctl_table	*ctl,
+	const struct ctl_table	*ctl,
 	int			write,
 	void			*buffer,
 	size_t			*lenp,

>  {
>  	int		ret, *valp = ctl->data;
>  
> @@ -30,12 +29,11 @@ xfs_stats_clear_proc_handler(
>  }
>  
>  STATIC int
> -xfs_panic_mask_proc_handler(
> -	struct ctl_table	*ctl,
> -	int			write,
> -	void			*buffer,
> -	size_t			*lenp,
> -	loff_t			*ppos)
> +xfs_panic_mask_proc_handler(const struct ctl_table *ctl,
> +			    int			write,
> +			    void			*buffer,
> +			    size_t			*lenp,
> +			    loff_t			*ppos)
>  {
>  	int		ret, *valp = ctl->data;
>  
> @@ -51,12 +49,11 @@ xfs_panic_mask_proc_handler(
>  #endif /* CONFIG_PROC_FS */
>  
>  STATIC int
> -xfs_deprecated_dointvec_minmax(
> -	struct ctl_table	*ctl,
> -	int			write,
> -	void			*buffer,
> -	size_t			*lenp,
> -	loff_t			*ppos)
> +xfs_deprecated_dointvec_minmax(const struct ctl_table *ctl,
> +			       int			write,
> +			       void			*buffer,
> +			       size_t			*lenp,
> +			       loff_t			*ppos)
>  {
>  	if (write) {
>  		printk_ratelimited(KERN_WARNING

And these need fixing as well.

A further quick glance at the patch reveals that there are other
similar screwed up conversions as well.

> diff --git a/kernel/delayacct.c b/kernel/delayacct.c
> index 6f0c358e73d8..513791ef573d 100644
> --- a/kernel/delayacct.c
> +++ b/kernel/delayacct.c
> @@ -44,8 +44,9 @@ void delayacct_init(void)
>  }
>  
>  #ifdef CONFIG_PROC_SYSCTL
> -static int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
> -		     size_t *lenp, loff_t *ppos)
> +static int sysctl_delayacct(const struct ctl_table *table, int write,
> +			    void *buffer,
> +			    size_t *lenp, loff_t *ppos)
>  {
>  	int state = delayacct_on;
>  	struct ctl_table t;

Like this.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..e2955e0d9f44 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -450,7 +450,8 @@ static void update_perf_cpu_limits(void)
>  
>  static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
>  
> -int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
> +int perf_event_max_sample_rate_handler(const struct ctl_table *table,
> +				       int write,
>  				       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int ret;

And this.

> @@ -474,8 +475,10 @@ int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
>  
>  int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
>  
> -int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
> -		void *buffer, size_t *lenp, loff_t *ppos)
> +int perf_cpu_time_max_percent_handler(const struct ctl_table *table,
> +				      int write,
> +				      void *buffer, size_t *lenp,
> +				      loff_t *ppos)
>  {
>  	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  

And this.

> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2fc2727d654..003f0f5cb111 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -239,9 +239,10 @@ static long hung_timeout_jiffies(unsigned long last_checked,
>  /*
>   * Process updating of timeout sysctl
>   */
> -static int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
> -				  void *buffer,
> -				  size_t *lenp, loff_t *ppos)
> +static int proc_dohung_task_timeout_secs(const struct ctl_table *table,
> +					 int write,
> +					 void *buffer,
> +					 size_t *lenp, loff_t *ppos)
>  {
>  	int ret;
>  

And this.

> diff --git a/kernel/latencytop.c b/kernel/latencytop.c
> index 781249098cb6..0a5c22b19821 100644
> --- a/kernel/latencytop.c
> +++ b/kernel/latencytop.c
> @@ -65,8 +65,9 @@ static struct latency_record latency_record[MAXLR];
>  int latencytop_enabled;
>  
>  #ifdef CONFIG_SYSCTL
> -static int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
> -		size_t *lenp, loff_t *ppos)
> +static int sysctl_latencytop(const struct ctl_table *table, int write,
> +			     void *buffer,
> +			     size_t *lenp, loff_t *ppos)
>  {
>  	int err;
>  

And this.

I could go on, but there are so many examples of this in the patch
that I think that it needs to be toosed away and regenerated in a
way that doesn't trash the existing function parameter formatting.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

